# This will clear out all of the redis cache, during boot

# WARNING: Do NOT call Rails.cache.clear, as it issues a flushdb command. Since we're sharing a
# redis with resque, this could cause problems

redis = REDIS.cache
keys = redis.keys
redis.del(*keys) if keys.any?