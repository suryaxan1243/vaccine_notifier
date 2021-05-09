class NotifierMailer < ApplicationMailer
  def notify(data)
    @data = data
    mail(to: MAILER_CONFIG['to_address'], subject: 'Vaccine Available')
  end
end
