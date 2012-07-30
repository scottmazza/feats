OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # Facebook authentication info  
  # Need to remove these from source control
  ENV['FACEBOOK_APP_ID'] = "463074820377113"
  ENV['FACEBOOK_SECRET'] = "3fef8d4dbf6e11ef205912df59dcd38a"
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
end