InertiaRails.configure do |config|
  config.ssr_enabled = Rails.env.production?
  config.version = ViteRuby.digest

  # The @inertiajs/vue3 v2+ client reads the initial page from a <script> element
  # (`getInitialPageFromDOM`), not the legacy `data-page` div attribute.
  config.use_script_element_for_initial_page = true

  # Always include an (empty) `errors` hash, the default in Inertia 4.
  # FlashMessages only renders the error banner when there are actual errors.
  config.always_include_errors_hash = true
end
