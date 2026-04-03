# frozen_string_literal: true

require 'simplecov'
SimpleCov.start { add_filter '/spec/' }

require 'better_settings'
require 'rspec/given'
require 'pry-byebug' if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.5.0')
