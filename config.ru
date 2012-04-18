# This file is used by Rack-based servers to start the application.
Encoding.default_external = "UTF-8"

require 'rack'
require 'rack/cache'
require 'redis-rack-cache'

def discover_redis_url_for(store_name)
  url = ENV['REDISTOGO_URL'] || ENV["Redis_URL_Rack_Cache_#{store_name}store"] || 'redis://localhost:6379/0'
  [url, "#{store_name}store"].join('/')
end

use Rack::Cache, metastore: discover_redis_url_for(:meta), entitystore: discover_redis_url_for(:entity)

require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'
require 'resque-retry/server'

use Rack::Deflater

# mount resque-web on the server
map '/resque' do
  run Resque::Server
end

# blitz.io authorization check
map '/mu-37f05861-eeb11cdb-7d50e0d0-b69d659d' do
  responder = proc { |env|
    [200, { 'Content-Type' => 'text/plain' }, ['42']]
  }

  run responder
end

map '/' do
  run ServiceProviderPortal::Application
end
