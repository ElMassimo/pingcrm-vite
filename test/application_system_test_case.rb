require "capybara/cuprite"
require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  BROWSER_PATH = ENV.fetch("CHROME_PATH") do
    # Find Playwright's bundled Chromium
    Dir.glob(File.join(Dir.home, ".cache/ms-playwright/chromium-*/chrome-linux/chrome")).max
  end
  private_constant :BROWSER_PATH

  CUPRITE_OPTIONS = { browser_path: BROWSER_PATH, headless: true, process_timeout: 30,
                      pending_connection_errors: false, browser_options: { "no-sandbox" => nil } }.freeze
  private_constant :CUPRITE_OPTIONS

  driven_by :cuprite, screen_size: [1400, 1400], options: CUPRITE_OPTIONS
end
