if Rails.env.development?
  TypesFromSerializers.config do |config|
    config.output_dir = 'app/javascript/types/serializers'
    config.custom_types_dir = 'app/javascript/types'
    config.sql_to_typescript_type_mapping.default = :any
    config.transform_keys = ->(key) { key }
  end
end
