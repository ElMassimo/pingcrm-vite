class ApplicationController < ActionController::Base
  include Auth

  include Pagy::Backend

  include InertiaCsrf
  include InertiaFlash
  include InertiaJson

  # Used in BaseSerializer.
  before_action { RequestLocals[:current_controller] = self }

  inertia_share user: -> { CurrentUserSerializer.one_if(current_user) }

  def paginate_data(items, serializer:)
    pagy, paged_items = pagy(items)
    { data: serializer.many(paged_items), meta: pagy_metadata(pagy) }
  end

  # Internal: Render a Vue page that matches the current controller name and action.
  def render_page(**props)
    render inertia: "#{controller_name}/#{action_name}", props: props
  end
end
