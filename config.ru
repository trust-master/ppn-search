# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'
require 'resque-retry/server'

map '/' do
  run ServiceProviderPortal::Application
end

map '/resque' do
  run Resque::Server
end