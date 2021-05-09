class VaccineNotifierWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info 'inside worker'

    url = VACCINE_CONFIG['search']['base_url']
    pincode = VACCINE_CONFIG['filters']['pincode']
    all_weeks_data = VACCINE_CONFIG['search']['no_of_weeks'].times.map do |i|
      params = {
        pincode: pincode,
        date: (Time.zone.now + i.weeks).to_date.strftime('%d-%m-%Y')
      }
      res = Faraday.get(url, params)
      return unless res.success?

      JSON.parse(res.body)
    end

    Rails.logger.info "#{all_weeks_data}"

    filtered_data = {centers: []}
    all_weeks_data.each do |week_data|
      week_data['centers'].each do |center|
        center['sessions'].each do |session|
          if session['min_age_limit'] == VACCINE_CONFIG['filters']['min_age_limit'] && session['available_capacity'] > 0
            center_details = {
              name: center['name'],
              address: center['address'],
              date: session['date'],
              available_capacity: session['available_capacity'],
              vaccine: session['vaccine']
            }
            filtered_data[:centers] << center_details
          end
        end
      end
    end
    return if filtered_data[:centers].blank?

    NotifierMailer.notify(filtered_data).deliver_later
  end
end
