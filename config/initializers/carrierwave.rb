if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAJ7VPEGIM37JCTZ7Q',
      aws_secret_access_key: '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'
    }
    config.fog_directory = 'feats'
    config.fog_public    = 'false'
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
end