InertiaRails.configure do |config|
  config.ssr_enabled = Rails.env.production?
  config.version = ViteRuby.digest
end
