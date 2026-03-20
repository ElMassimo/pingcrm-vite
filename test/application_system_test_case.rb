require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :cuprite, screen_size: [1400, 1400], options: {
    browser_path: "/root/.cache/ms-playwright/chromium-1194/chrome-linux/chrome",
    headless: true,
    process_timeout: 30,
    browser_options: { "no-sandbox" => nil },
  }
end
