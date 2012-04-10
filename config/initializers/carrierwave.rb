CarrierWave.configure do |config|
  s3_credentials = ServiceProviderPortal::Application.config.s3_credentials
  config.fog_credentials = {
    :provider               => 'AWS',                                     # required
    :aws_access_key_id      => s3_credentials[:access_key_id],            # required
    :aws_secret_access_key  => s3_credentials[:secret_access_key]         # required
    # :region                 => 'eu-west-1'                              # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = s3_credentials[:bucket]                         # required
  # config.fog_public     = false                                           # optional, defaults to true
  # config.fog_host       = 'https://assets.example.com'                  # optional, defaults to nil
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}        # optional, defaults to {}
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:].\-\+]/