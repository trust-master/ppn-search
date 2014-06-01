Spring.after_fork do
  Sidekiq.configure_client do |config|
    config.redis = ServiceProviderPortal::Application.config.redis_settings.sidekiq
  end

  Rails.cache.reconnect
end
