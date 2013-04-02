require_relative 'production'

ServiceProviderPortal::Application.configure do
  # Allow passing debug_assets=true as a query parameter to load pages with unpackaged assets
  config.assets.allow_debugging = true
end
