source 'https://rubygems.org'
ruby '2.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'rails_12factor', group: :production

# Use SCSS for stylesheets
gem 'sass'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem "therubyracer"
gem 'less-rails'
gem 'devise', '3.4.1'
gem 'solid_use_case'
gem "autoprefixer-rails"
gem 'react-rails', '~> 1.0'
gem 'materialize-sass'

# performance monitoring
gem 'newrelic_rpm'

group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'capybara', '~> 2.4.1'
  gem "codeclimate-test-reporter", require: nil
end

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'


# Use debugger
# gem 'debugger'

group :development do
  #startup
  gem "foreman"

  # helpers
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"

  # Use Capistrano for deployment
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bower'
end
