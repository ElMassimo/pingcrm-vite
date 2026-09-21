# frozen_string_literal: true

require "rails_helper"
require "capybara/cuprite"
require "capybara_test_helpers/rspec"

Capybara.server = :puma, {Silent: true}
Capybara.save_path = Rails.root.join("tmp/capybara")
Capybara.javascript_driver = :cuprite

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1400, 1400],
    js_errors: true,
    headless: %w[0 false].exclude?(ENV["HEADLESS"]),
  )
end

CapybaraTestHelpers.config.helpers_paths = [Rails.root.join("spec/integration_test_helpers")]
require Rails.root.join("spec/integration_test_helpers/base_test_helper")

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.define_derived_metadata(type: :feature) { |metadata| metadata[:js] = true }
end
