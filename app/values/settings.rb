# frozen_string_literal: true

class Settings < BetterSettings
  source Rails.root.join("config/application.yml"), namespace: Rails.env
  source Rails.root.join("config/development.yml"), namespace: Rails.env, optional: true if Rails.env.development?
  source Rails.root.join("config/test.yml"), namespace: Rails.env, optional: true if Rails.env.test?
end
