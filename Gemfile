source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

# A robust settings library for Ruby. Access your settings by calling methods on a safe immutable object (https://github.com/ElMassimo/better_settings)
gem 'better_settings'

# Full-stack web application framework. (https://rubyonrails.org)
gem 'rails', '~> 8.0'

# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/] (https://github.com/ged/ruby-pg)
gem 'pg', '>= 0.18', '< 2.0'

# Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications (https://puma.io)
gem 'puma', '>= 5.0'

# Create JSON structures via a Builder-style DSL (https://github.com/rails/jbuilder)
gem 'jbuilder', '~> 2.7'

# High-level wrapper for processing images for the web with ImageMagick or libvips. (https://github.com/janko/image_processing)
gem 'image_processing', '~> 1.10'

# Boot large ruby/rails apps faster (https://github.com/Shopify/bootsnap)
gem 'bootsnap', require: false

# Provides integration to manage frontend assets with Vite.js (https://github.com/ElMassimo/vite_ruby)
gem 'vite_rails'

# Allows to register per-request thread-safe variables (https://github.com/ElMassimo/request_store_rails)
gem 'request_store_rails'

group :development, :test do
  # Ruby fast debugger - base + CLI (https://github.com/ruby/debug)
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Automatic Ruby code style checking tool. (https://github.com/rubocop-hq/rubocop)
  gem 'rubocop', require: false

  # Automatic performance checking tool for Ruby code. (https://github.com/rubocop-hq/rubocop-performance)
  gem 'rubocop-performance', require: false

  # Automatic Rails code style checking tool. (https://github.com/rubocop-hq/rubocop-rails)
  gem 'rubocop-rails', require: false

  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer (https://github.com/thoughtbot/factory_bot_rails)
  gem 'factory_bot_rails'
end

group :development do
  # A debugging tool for your Ruby on Rails applications. (https://github.com/rails/web-console)
  gem 'web-console', '>= 4.1.0'

  # Profiles loading speed for rack applications. (https://miniprofiler.com)
  gem 'rack-mini-profiler', '~> 2.0'

  # Brings Rails named routes to modern javascript (https://github.com/elmassimo/js_from_routes)
  gem 'js_from_routes'
end

group :test do
  # Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb (https://github.com/teamcapybara/capybara)
  gem 'capybara', '>= 3.26'

  # The next generation developer focused tool for automated testing of webapps (https://github.com/SeleniumHQ/selenium)
  gem 'selenium-webdriver'

  # Headless Chrome driver for Capybara using CDP (https://github.com/rubycdp/cuprite)
  gem 'cuprite'
end

# Timezone Data for TZInfo (https://tzinfo.github.io)
gem 'tzinfo-data', platforms: [:windows, :jruby]

# Inertia adapter for Rails (https://github.com/inertiajs/inertia-rails)
gem 'inertia_rails', '>= 3.0'

# Easily generate fake data (https://github.com/faker-ruby/faker)
gem 'faker', require: false

# The Ultimate Pagination Ruby Gem (https://github.com/ddnexus/pagy)
gem 'pagy', '~> 9.0'

# Flexible authentication solution for Rails with Warden (https://github.com/heartcombo/devise)
gem 'devise'

# A fast JSON parser and serializer. (http://www.ohler.com/oj)
gem 'oj'

# Faster JSON serialization for Ruby on Rails. Easily migrate away from Active Model Serializers (https://github.com/ElMassimo/oj_serializers)
gem 'oj_serializers'

# Simple authorization solution for Rails. (https://github.com/CanCanCommunity/cancancan)
gem 'cancancan'
