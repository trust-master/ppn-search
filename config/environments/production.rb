ServiceProviderPortal::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # See everything in the log (default is :info)
  config.log_level = ENV['RAILS_LOG_LEVEL'].presence || :info

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  ### ASSETS ###

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Enable Rails's static asset server (to serve assets on Heroku)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true
  config.assets.css_compressor = :yui
  config.assets.js_compressor = :uglifier

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  config.static_cache_control = 'public, max-age=%i' % 1.month

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  config.action_controller.asset_host = ENV['ASSET_HOST'].presence

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w[
      ie8.css
      ie7.css
      ie.css
      print.css
      modernizr.min.js
      active_admin.css
      active_admin/print.css
      active_admin.js
  ]

  ### Caching ###
  config.action_dispatch.rack_cache = {
    :metastore    => config.redis_settings[:rack_cache_metastore][:url],
    :entitystore  => config.redis_settings[:rack_cache_entitystore][:url],
    :allow_reload => false
  }

  ### ActionMailer ###

  # Disable delivery errors, bad email addresses will be ignored
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  # Set the default url options for ActionMailer (so it knows how to generate URLs, for example)
  config.action_mailer.default_url_options = {
    host: ENV['DOMAIN_NAME']
  }
  config.action_mailer.smtp_settings = {
    port:                 ENV['SMTP_PORT'] || 587,
    address:              ENV['SMTP_HOST'] || 'smtp.gmail.com',
    user_name:            ENV['SMTP_LOGIN'],
    password:             ENV['SMTP_PASSWORD'],
    from:                 ENV['SMTP_FROM'] || 'info@trust-master.com',
    domain:               ENV['SMTP_DOMAIN'] || 'trust-master.com',
    authentication:       :plain,
    enable_starttls_auto: true
  }

end
