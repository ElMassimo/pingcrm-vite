if Rails.env.development?
  JsFromRoutes.config do |config|
    config.client_library = '@js-from-routes/inertia'
    config.helper_mappings = {"index" => "index", "show" => "show"}
    config.file_suffix = 'Api.ts'
  end
end
