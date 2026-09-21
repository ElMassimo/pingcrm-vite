require "test_helper"
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1400, 1400],
    # Fail the test when the page logs an uncaught JS error (replaces the
    # Selenium-specific browser-log assertion we used before).
    js_errors: true,
    headless: %w[0 false].exclude?(ENV["HEADLESS"]),
  )
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :cuprite
end
