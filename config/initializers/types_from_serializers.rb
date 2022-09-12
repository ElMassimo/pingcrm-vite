if Rails.env.development?
  TypesFromSerializers.config do |config|
    config.output_dir = Rails.root.join('app/frontend/serializers')
  end
end
