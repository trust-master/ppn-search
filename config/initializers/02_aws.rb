# Define config.s3_credentials for use by Fog and other gems
ServiceProviderPortal::Application.configure do

  config.s3_credentials = HashWithIndifferentAccess.new
  yaml_file = Rails.root.join('config','s3.yml')

  yml_config = YAML.load_file( yaml_file )[Rails.env] if File.exists?(yaml_file)
  yml_config ||= {} # just so I can still treat the local like a hash, even if the file was not found

  config.s3_credentials = hash = HashWithIndifferentAccess.new({
    bucket:            ENV['AWS_S3_Bucket']            || yml_config['bucket'],
    access_key_id:     ENV['AWS_S3_Access_Key_ID']     || yml_config['access_key_id'],
    secret_access_key: ENV['AWS_S3_Secret_Access_Key'] || yml_config['secret_access_key']
  }).freeze

  unless hash[:bucket] and hash[:access_key_id] and hash[:secret_access_key]
    raise "You didn't configure S3 credentials!!"
  end
end