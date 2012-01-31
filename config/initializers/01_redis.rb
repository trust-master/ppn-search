local = 'redis://localhost:6379/2'

ServiceProviderPortal::Application.configure do
  if ENV["REDISTOGO_URL"]
    # Set every Redis to that URL, since we're using RedisToGo and we don't want to use multiple servers
    redis_client = Redis.connect(url: ENV["REDISTOGO_URL"])
    REDIS = {
      default: redis_client,
      resque: redis_client
    }

  else
    # Read from config/redis.yml if it exists
    yml_file = Rails.root.join('config','redis.yml')
    if File.exists?(yml_file)
      yml_config = YAML.load_file(yml_file)[Rails.env]
      $stderr.puts <<-MSG.gsub(/\s+/, ' ') if yml_config.nil?
        \033[1;31m WARNING: config/redis.yml was found, but contains no configuration for
        [#{Rails.env}]. Are you sure the structure of that file matches that of
        config/redis.yml.example?\033[m
      MSG
    end
    yml_config ||= {}

    config.redis_urls = HashWithIndifferentAccess.new({
      default:         ENV['Redis_URL']                 || yml_config[:default]         || local,
      resque:          ENV['Redis_URL_Resque']          || yml_config[:resque]          || local
    })

    REDIS = Hash.new do |hash, key|
      hash[key] = Redis.connect(url: config.redis_urls[key])
    end
  end
end