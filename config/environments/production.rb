ServiceProviderPortal::Application.configure do
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and your application in memory, allowing both thread web servers and those relying on copy on write to perform better. Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # See everything in the log (default is :info)
  config.log_level = ENV['RAILS_LOG_LEVEL'].presence || :info

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  ### ASSETS ###
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  config.assets.digest = true
  config.assets.version = '1.0'
  config.serve_static_assets = true
  config.static_cache_control = 'public, max-age=%i' % 1.month
  config.action_controller.asset_host = ENV['ASSET_HOST'].presence

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

  config.action_dispatch.rack_cache = {
    :metastore    => config.redis_settings[:rack_cache_metastore][:url],
    :entitystore  => config.redis_settings[:rack_cache_entitystore][:url],
    :allow_reload => false
  }

  ### ActionMailer ###

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
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
