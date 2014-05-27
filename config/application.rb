require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "active_resource/railtie"
require "sprockets/railtie"


# Load all the preinitializers
Dir[File.expand_path('../preinitializers/*.rb', __FILE__)].each { |f| require f }
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

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
    config.active_record.observers = %w[
      company_observer
      company_profile_sweeper
      company_sweeper
      popular_categories_sweeper
      scrape_observer
      scraped_model_defaults_observer
      user_auth_token_observer
      user_observer
    ]

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
    config.i18n.default_locale = 'en'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    # config.redis_settings is set up in the preinitializers/redis.rb file
    config.cache_store = :redis_store, config.redis_settings.cache

    # Don't initialize the app during asset precompilation
    config.assets.initialize_on_precompile = false
  end
end
