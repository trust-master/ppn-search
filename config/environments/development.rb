ServiceProviderPortal::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = !! ENV['ENABLE_CACHING']

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

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
  config.action_mailer.default_url_options = { host: 'local-dev.trust-master.herokuapp.com:3000' }

  # Send mails to a file within tmp/mails/
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    port:                 ENV['SMTP_PORT'] || 1025,
    address:              ENV['SMTP_HOST'] || 'localhost',
    user_name:            ENV['SMTP_LOGIN'],
    password:             ENV['SMTP_PASSWORD'],
    from:                 ENV['SMTP_FROM'] || 'info@trust-master.com',
    domain:               ENV['SMTP_DOMAIN'] || 'trust-master.com'
  }
  config.action_mailer.raise_delivery_errors = true

end
