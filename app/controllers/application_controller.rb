class ApplicationController < ActionController::Base
  include Auth

  include Pagy::Method

  include InertiaCsrf
  include InertiaFlash

  # Used in BaseSerializer.
  before_action { RequestLocals[:current_controller] = self }

  inertia_share current_user: -> { CurrentUserSerializer.one_if(current_user) }

  def paginate_data(items, serializer:)
    pagy, paged_items = pagy(:offset, items)
    {data: serializer.many(paged_items), meta: pagy.data_hash}
  end

  def redirect_to_index(record, unprocessable: false, **options)
    redirect_to_record_path polymorphic_path(record.class), record, unprocessable:, **options
  end

  def redirect_to_new(record, unprocessable: false, **options)
    redirect_to_record_path new_polymorphic_path(record.class), record, unprocessable:, **options
  end

  def redirect_to_edit(record, unprocessable: false, **options)
    redirect_to_record_path edit_polymorphic_path(record), record, unprocessable:, **options
  end

  def redirect_to_record_path(path, record, unprocessable:, **options)
    options[:inertia] = options.fetch(:inertia, {}).merge(errors: record.errors) if unprocessable
    redirect_to path, **options
  end
  private :redirect_to_record_path

  # Internal: Render a Vue page that matches the current controller name and action.
  def render_page(**props)
    render inertia: "#{controller_name}/#{action_name}", props:
  end
end
