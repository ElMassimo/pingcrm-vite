# frozen_string_literal: true

class Settings < BetterSettings
  source "#{ File.dirname(__FILE__) }/settings.yml"
  source "#{ File.dirname(__FILE__) }/settings_empty.yml"

  def self.custom
    'CUSTOM'
  end

  def self.global
    'GLOBAL'
  end
end

class DevSettings < BetterSettings
  source "#{ File.dirname(__FILE__) }/settings.yml", namespace: :development
  source "#{ File.dirname(__FILE__) }/dev.yml", namespace: 'development'
end

class NoSettings < BetterSettings
  source "#{ File.dirname(__FILE__) }/settings_empty.yml", optional: true
  source "#{ File.dirname(__FILE__) }/settings_none.yml", optional: true
end

class NoSource < BetterSettings
end
