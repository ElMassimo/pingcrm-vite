class ContactsController < ApplicationController
  # Let CanCanCan load and authorize the instance variables
  load_and_authorize_resource

  def index
    filters = params.permit(:search, :trashed).to_keywords
    contacts = ContactsQuery.wrap(@contacts).includes(:organization)
      .search(**filters).by_name

    render_page(
      contacts: paginate_data(contacts, serializer: ContactSerializer),
      filters:,
    )
  end

  def new
    render_page(
      contact: ContactFormSerializer.one(@contact),
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
      redirect_to_index @contact, notice: "Contact created."
    else
      redirect_to_new @contact, unprocessable: true
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to_edit @contact, notice: "Contact updated."
    else
      redirect_to_edit @contact, unprocessable: true
    end
  end

  def destroy
    if @contact.soft_delete
      if can? :edit, @contact
        redirect_to_edit @contact, notice: "Contact deleted."
      else
        redirect_to_index @contact, notice: "Contact deleted."
      end
    else
      redirect_to_edit @contact, alert: "Contact cannot be deleted!"
    end
  end

  def restore
    if @contact.restore
      redirect_to_edit @contact, notice: "Contact restored."
    else
      redirect_to_edit @contact, alert: "Contact cannot be restored!"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.expect(
      contact: %i[
        organization_id first_name last_name email phone address city region country postal_code
      ],
    )
  end
end
