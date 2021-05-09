# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Purpose
  -
  This application runs a worker in background once in every 15 mins to check for the vaccine slots availability, by default the time range for search is `4 weeks`, i.e, this app notifies vaccine availability through a mail if it finds any slot available in next 4 weeks. The filters for slot search are taken from `vaccine_config.rb` file.
* Ruby version
  - 2.7.2

* Rails version
  - 6.1.3

* Configuration
  -
  1. Update the filters as required in `vaccine_config.rb`.
  2. Update the `to_address` in `mailer_config.rb` file.
  3. Add your gmail username and password in the `development.rb` file under action_mailer smtp settings.
      * If you have 2 step verification for your gmail account, generate an app password and use it instead of your actual password. You can check a step by step process of how to sign in using app passwords [here](https://support.google.com/mail/answer/185833?hl=en-GB).
      * If 2 step verification is not enabled for your gmail account, then you can use your actual password, but you might need to enable `sign in from less secure apps`. Refer this [link](https://support.google.com/accounts/answer/6010255?hl=en#zippy=%2Cif-less-secure-app-access-is-on-for-your-account) for the same.

* Running in your local
  - 
  1. Fork the application and navigate to root directory in your terminal.
  2. run `bundle install`.
  3. run `bundle exec sidekiq`, you can see a worker running once in 15 mins to check for slots availability.

