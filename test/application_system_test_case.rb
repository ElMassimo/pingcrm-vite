require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  BROWSER_PATH = ENV.fetch("CHROME_PATH") {
    # Find Playwright's bundled Chromium
    Dir.glob(File.join(Dir.home, ".cache/ms-playwright/chromium-*/chrome-linux/chrome")).max
  }

  driven_by :cuprite, screen_size: [1400, 1400], options: {
    browser_path: BROWSER_PATH,
    headless: true,
    process_timeout: 30,
    browser_options: { "no-sandbox" => nil },
  }
end
