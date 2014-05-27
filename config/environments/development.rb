ServiceProviderPortal::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = ENV['ENABLE_CACHING'] == '1'

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  ### ASSETS ###
  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.sass.debug_info = true
  config.sass.style = :nested

  # Use digest sums on the end of Asset URLs, for debugging
  # config.assets.digest = true

  ### ActionMailer ###
  # Set the default url options for ActionMailer (so it knows how to generate URLs, for example)
  config.action_mailer.default_url_options = {
    host: 'local-dev.trust-master.herokuapp.com:3000'
  }

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    port:                 ENV['SMTP_PORT'] || 1025,
    address:              ENV['SMTP_HOST'] || 'localhost',
    user_name:            ENV['SMTP_LOGIN'],
    password:             ENV['SMTP_PASSWORD'],
    from:                 ENV['SMTP_FROM'] || 'info@trust-master.com',
    domain:               ENV['SMTP_DOMAIN'] || 'trust-master.com'
  }
end
