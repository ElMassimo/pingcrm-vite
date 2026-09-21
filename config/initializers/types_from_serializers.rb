if Rails.env.development?
  TypesFromSerializers.config do |config|
    config.output_dir = Rails.root.join("app/frontend/serializers")

    # oj_serializers emits attribute names verbatim (snake_case), so keep the
    # generated TypeScript keys snake_case too. (The gem defaults to camelCase,
    # which would not match the actual JSON.)
    config.transform_keys = ->(key) { key.to_s.chomp("?") }
  end
end
