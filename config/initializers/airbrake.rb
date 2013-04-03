if api_key = ENV['airbrake_api_key'] and host = ENV['airbrake_host']
  Airbrake.configure do |config|
    config.api_key = api_key
    config.host    = host
    config.port    = ENV['airbrake_port'] || 80
    config.secure  = config.port == 443
    config.development_environments = []
  end
else
  puts 'Not using Airbrake!'
end
