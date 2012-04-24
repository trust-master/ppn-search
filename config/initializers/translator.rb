redis = Redis::Factory.create(ServiceProviderPortal::Application.config.redis_urls[:i18n])

Translator.current_store = Translator::RedisStore.new(redis)
I18n.backend = Translator.setup_backend(I18n::Backend::Simple.new)

Translator.locales = [:en]