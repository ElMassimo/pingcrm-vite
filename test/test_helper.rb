ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'

Capybara.server = :puma, { Silent: true } # To clean up your test output
Capybara.default_max_wait_time = 5

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end
