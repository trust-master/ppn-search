# Use Redis for translations store, fall back to YAML
if Rails.env.development?
  I18n.backend = I18n::Backend::Chain.new(
    I18n::Backend::Redis.new(ServiceProviderPortal::Application.config.redis_settings.i18n),
    I18n.backend
  )
end

CURRENT_YEAR=Date.today.year
