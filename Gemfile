source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'jquery-rails'
gem 'omniauth-facebook'
gem 'geocoder'
gem 'carrierwave'
gem 'rmagick'
gem 'rack-google-analytics'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec', '0.5.5'
end

gem 'annotate', '~> 2.4.1.beta', group: :development

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
  gem 'sass-rails',   '3.2.4'
  gem 'twitter-bootstrap-rails'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '0.9.1', :require => false
  gem 'growl', '1.0.3'
  gem 'guard-spork', '0.3.2'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '1.4.0'
end

group :production do
  gem 'pg', '0.12.2'
  gem 'fog', '~> 1.3.1'
end
