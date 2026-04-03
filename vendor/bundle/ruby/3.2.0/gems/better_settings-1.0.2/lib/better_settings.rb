# frozen_string_literal: true

require 'yaml'
require 'erb'
require 'open-uri'
require 'forwardable'

# Public: Rewrite of BetterSettings to enforce fail-fast and immutability, and
# avoid extending a core class like Hash which can be problematic.
class BetterSettings
  extend Forwardable

  VALID_SETTING_NAME = /^\w+$/
  RESERVED_METHODS = %w[
    settings
    root_settings
  ]

  attr_reader :settings

  def_delegators :settings, :to_h, :to_hash

  # Public: Initializes a new settings object from a Hash or compatible object.
  def initialize(hash, parent:)
    @settings = hash.to_h.freeze
    @parent = parent

    # Create a getter method for each setting.
    @settings.each { |key, value| create_accessor(key, value) }
  end

  # Internal: Returns a new Better Settings instance that combines the settings.
  def merge(other_settings)
    self.class.new(deep_merge(@settings, other_settings.to_h), parent: @parent)
  end

  # Internal: Display explicit errors for typos and missing settings.
  def method_missing(name, *)
    raise MissingSetting, "Missing setting '#{ name }' in #{ @parent }"
  end

private

  # Internal: Wrap nested hashes as settings to allow accessing keys as methods.
  def auto_wrap(key, value)
    case value
    when Hash then self.class.new(value, parent: "'#{ key }' section in #{ @parent }")
    when Array then value.map { |item| auto_wrap(key, item) }.freeze
    else value.freeze
    end
  end

  # Internal: Defines a getter for the specified setting.
  def create_accessor(key, value)
    raise InvalidSettingKey if !key.is_a?(String) || key !~ VALID_SETTING_NAME || RESERVED_METHODS.include?(key)

    instance_variable_set("@#{ key }", auto_wrap(key, value))
    singleton_class.send(:attr_reader, key)
  end

  # Internal: Recursively merges two hashes (in case ActiveSupport is not available).
  def deep_merge(this_hash, other_hash)
    this_hash.merge(other_hash) do |_key, this_val, other_val|
      if this_val.is_a?(Hash) && other_val.is_a?(Hash)
        deep_merge(this_val, other_val)
      else
        other_val
      end
    end
  end

  class MissingSetting < StandardError; end

  class InvalidSettingKey < StandardError; end

  class << self
    extend Forwardable
    def_delegators :root_settings, :to_h, :to_hash, :method_missing

    # Public: Loads a file as settings (merges it with any previously loaded settings).
    def source(file_name, namespace: false, optional: false)
      return if !File.exist?(file_name) && optional

      # Load the specified yaml file and instantiate a Settings object.
      settings = new(yaml_to_hash(file_name), parent: file_name)

      # Take one of the settings keys if one is specified.
      settings = settings.public_send(namespace) if namespace

      # Merge settings if a source had previously been specified.
      @root_settings = @root_settings ? @root_settings.merge(settings) : settings

      # Allow to call any settings methods directly on the class.
      singleton_class.extend(Forwardable)
      singleton_class.def_delegators :root_settings, *@root_settings.settings.keys
    end

  private

    # Internal: Methods called at the class level are delegated to this instance.
    def root_settings
      raise ArgumentError, '`source` must be specified for the settings' unless defined?(@root_settings)

      @root_settings
    end

    # Internal: Parses a yml file that can optionally use ERB templating.
    def yaml_to_hash(file_name)
      return {} if (content = File.open(file_name).read).empty?

      YAML.load(ERB.new(content).result, aliases: true).to_hash
    end
  end
end
