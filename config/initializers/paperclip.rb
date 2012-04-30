s3_credentials = Rails.application.config.s3_credentials
Paperclip::Attachment.default_options.update({

  styles: {
    thumb:   ['100', :png],
    preview: ['800>', :png]
  },

  path:     'uploads/:class/:attachment/:id/:normalized_basename_:style_:fingerprint.:extension',
  default_url: '', # blank, so I can catch it with logic to avoid showing missing images altogether

  storage: :fog,
  fog_credentials: {
    provider:              'AWS',
    # region:                'us-east-1',
    aws_access_key_id:     s3_credentials[:access_key_id],
    aws_secret_access_key: s3_credentials[:secret_access_key]
  },
  fog_directory:  s3_credentials[:bucket],
  fog_public:     true,
  # fog_host:       'https://assets.example.com',
  fog_attributes: {
    'Cache-Control' => "public,max-age=#{1.year.seconds.to_i}"
  }

})

Paperclip.interpolates(:normalized_basename) do |attachment, style|
  basename(attachment, style).parameterize
end
