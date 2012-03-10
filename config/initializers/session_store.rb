# Be sure to restart your server when you modify this file.

ServiceProviderPortal::Application.config.session_store :cookie_store, :key => '_TrustMaster_ServiceProvider_Portal_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# ServiceProviderPortal::Application.config.session_store :active_record_store


# Use redis-store for Rack::Sessions:
#   Optional params:
#     :expire_in => TTL in seconds # :expires_in or :expire_after work as well, see https://github.com/jodosha/redis-store/blob/master/lib/redis/store/ttl.rb#L32
#     :key_prefix => prefix/namespace to be used
# ServiceProviderPortal::Application.session_store :redis_session_store,
#   :servers => config.redis_urls[:session]
