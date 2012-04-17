require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module ServiceProviderPortal
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths << "#{config.root}/lib"
    config.autoload_paths += Dir["#{config.root}/lib/{validators,extensions,filters}/"]
    # config.autoload_paths += %W(#{config.root}/extras)

    # Activate observers that should always be running.
    config.active_record.observers = [ :user_observer,
                                       :scrape_observer,
                                       :scraped_model_defaults_observer ]

    # generate RSpec tests for views and helpers
    config.generators do |g|
      g.test_framework :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs true
      g.helper_specs true
    end

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('app', 'strings', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'en-US'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_digest]

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Configure the Redis URLs here, so I can set up the Redis cache store below...
    config.redis_urls = Hash.new do |hash, key|
      keys = ENV.keys.grep(/REDISTOGO_URL|Redis_URL_#{key}/i).sort
      key = key.downcase.to_sym
      fallback = "redis://localhost:6379/0/#{key unless key == :default}"
      hash[key] = [*ENV.values_at(*keys), fallback].compact.first
    end

    config.cache_store = :redis_store, config.redis_urls[:cache]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Don't initialize the app during asset precompilation
    config.assets.initialize_on_precompile = false

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
