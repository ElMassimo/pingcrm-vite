class ContactsController < ApplicationController
  # Let CanCanCan load and authorize the instance variables
  load_and_authorize_resource

  def index
    contacts = @contacts.
               includes(:organization).
               search(params[:search]).
               trash_filter(params[:trashed]).
               order_by_name

    render_page(
      contacts: paginate_data(contacts, serializer: ContactSerializer),
      filters: params.slice(:search, :trashed),
    )
  end

  def new
    render_page(
      organizations: ModelSerializer.many(current_user.organizations.order(:name)),
    )
  end

  def edit
    render_page(
      contact: ContactFormSerializer.one(@contact),
      organizations: ModelSerializer.many(current_user.organizations.order(:name)),
    )
  end

  def create
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: 'Contact created.'
    else
      redirect_to new_contact_path, inertia: { errors: @contact.errors }
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to edit_contact_path(@contact), notice: 'Contact updated.'
    else
      redirect_to edit_contact_path(@contact), inertia: { errors: @contact.errors }
    end
  end

  def destroy
    if @contact.soft_delete
      if can? :edit, @contact
        redirect_to edit_contact_path(@contact), notice: 'Contact deleted.'
      else
        redirect_to contacts_path, notice: 'Contact deleted.'
      end
    else
      redirect_to edit_contact_path(@contact), alert: 'Contact cannot be deleted!'
    end
  end

  def restore
    if @contact.restore
      redirect_to edit_contact_path(@contact), notice: 'Contact restored.'
    else
      redirect_to edit_contact_path(@contact), alert: 'Contact cannot be restored!'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.fetch(:contact, {}).permit(
      :organization_id, :first_name, :last_name, :email, :phone, :address, :city,
      :region, :country, :postal_code
    )
  end
end
