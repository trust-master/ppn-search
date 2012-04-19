# This file is used by Rack-based servers to start the application.
Encoding.default_external = "UTF-8"

require 'bundler/setup'

require 'rack'

# Use GZIP compression
use Rack::Deflater

require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'
require 'resque-retry/server'

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
