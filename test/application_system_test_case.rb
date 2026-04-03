require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  if ENV['CHROMEDRIVER_PATH'].present?
    Selenium::WebDriver::Chrome::Service.driver_path = -> { ENV['CHROMEDRIVER_PATH'] }
  end

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
