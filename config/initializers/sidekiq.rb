# REDIS_CONFIG = { url: REDIS[:sidekiq], namespace: 'sidekiq' }
Sidekiq.configure_server do |config|
  config.redis = ServiceProviderPortal::Application.config.redis_settings.sidekiq
end

Sidekiq.configure_client do |config|
  config.redis = ServiceProviderPortal::Application.config.redis_settings.sidekiq
end

Jobs::Scheduler.enqueue