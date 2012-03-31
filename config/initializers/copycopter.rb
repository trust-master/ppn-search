# if ENV.has_key?('COPYCOPTER_ENABLED')
#   CopycopterClient.configure do |config|
#     config.api_key = 'be43768f98b212763314a6d77b0fb7e0'
#     config.host = 'trust-master-copy.herokuapp.com'
#     config.http_read_timeout = 60
#     config.http_open_timeout = 60
#     config.polling_delay = 10 unless Rails.env.production? # seconds, defaults to 300 seconds or 5 minutes
#     config.middleware = nil
#   end
# end