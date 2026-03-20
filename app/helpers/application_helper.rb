module ApplicationHelper
  # PATCH: See https://github.com/rails/rails/pull/41697
  def send_preload_links_header(sources)
    super(sources.map { |source| source.include?('application') && source.include?('.js') ? source.sub('=preload', '=modulepreload') : source })
  end
end
