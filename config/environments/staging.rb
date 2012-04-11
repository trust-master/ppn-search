require_relative 'production'

ServiceProviderPortal::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Full error reports are enabled
  config.consider_all_requests_local = true

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :log

  ### ASSETS ###

  # Allow passing debug_assets=true as a query parameter to load pages with unpackaged assets
  config.assets.allow_debugging = true
  config.action_controller.asset_host = "do4pzk3e3dtn3.cloudfront.net"

  ### ActionMailer ###

  # Disable delivery errors, bad email addresses will be ignored
  config.action_mailer.raise_delivery_errors = true

  # Set the default url options for ActionMailer (so it knows how to generate URLs, for example)
  config.action_mailer.default_url_options = {
    host: 'trust-master.herokuapp.com'
  }
  config.action_mailer.delivery_method = :smtp
end

Resque.inline = true