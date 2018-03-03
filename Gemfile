source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.5'
gem 'puma', '~> 3.7'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'pg'
gem 'sidekiq'
gem 'zhong'

# api
gem 'grape', '~> 1.0'
gem 'grape-entity', '~> 0.7'
gem 'grape_on_rails_routes'
gem 'grape-swagger', '~> 0.27'
gem 'grape-swagger-rails', '~> 0.3'
gem 'grape-swagger-entity', '~> 0.2'

# client_for_api
gem 'httparty'

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'rubocop'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'capybara', '~> 2.13'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end
