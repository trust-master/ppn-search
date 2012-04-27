# Use Redis for translations store, fall back to YAML
# I18n.backend = I18n::Backend::Chain.new(
#   I18n::Backend::Redis.new(ServiceProviderPortal::Application.config.redis_urls[:i18n]),
#   I18n.backend
# )