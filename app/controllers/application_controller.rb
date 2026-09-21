class ApplicationController < ActionController::Base
  include Auth

  include Pagy::Method

  include InertiaCsrf
  include InertiaFlash

  # Used in BaseSerializer.
  before_action { RequestLocals[:current_controller] = self }

  inertia_share user: -> { CurrentUserSerializer.one_if(current_user) }

  def paginate_data(items, serializer:)
    pagy, paged_items = pagy(:offset, items)
    {data: serializer.many(paged_items), meta: pagy.data_hash}
  end

  # Internal: Render a Vue page that matches the current controller name and action.
  def render_page(**props)
    render inertia: "#{controller_name}/#{action_name}", props:
  end
end
