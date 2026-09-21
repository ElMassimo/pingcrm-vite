class OrganizationsController < ApplicationController
  # Let CanCanCan load and authorize the instance variables
  load_and_authorize_resource

  def index
    filters = params.permit(:search, :trashed).to_keywords
    organizations = OrganizationsQuery.wrap(@organizations).search(**filters).by_name

    render_page(
      organizations: paginate_data(organizations, serializer: OrganizationSerializer),
      filters:,
    )
  end

  def edit
    render_page(
      organization: OrganizationFormSerializer.one(@organization),
      contacts: -> { ContactListSerializer.many(ContactsQuery.wrap(@organization.contacts).by_name) },
    )
  end

  def create
    if @organization.update(organization_params)
      redirect_to organizations_path, notice: "Organization created."
    else
      redirect_to organizations_path, inertia: {errors: @organization.errors}
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to edit_organization_path(@organization), notice: "Organization updated."
    else
      redirect_to edit_organization_path(@organization), inertia: {errors: @organization.errors}
    end
  end

  def destroy
    if @organization.soft_delete
      if can? :edit, @organization
        redirect_to edit_organization_path(@organization), notice: "Organization deleted."
      else
        redirect_to organizations_path, notice: "Organization deleted."
      end
    else
      redirect_to edit_organization_path(@organization), alert: "Organization cannot be deleted!"
    end
  end

  def restore
    if @organization.restore
      redirect_to edit_organization_path(@organization), notice: "Organization restored."
    else
      redirect_to edit_organization_path(@organization), alert: "Organization cannot be restored!"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.expect(
      organization: %i[name email phone address city region country postal_code],
    )
  end
end
