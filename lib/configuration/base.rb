# This is used by preinitializers for determining app root and environment, before the app
# configuration is loaded

require 'active_support/string_inquirer'
require 'pathname'

module BaseConfig
  def rails_env
    if defined?(Rails)
      Rails.env
    else
      ActiveSupport::StringInquirer.new(ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development")
    end
  end

  def rails_root
    if defined?(Rails)
      Rails.root
    else
      Pathname.new(File.expand_path('../../..', __FILE__))
    end
  end
end