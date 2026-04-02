# frozen_string_literal: true

# Public: Used in organizations edit page contacts table.
class OrganizationContactSerializer < BaseSerializer
  object_as :contact, model: :Contact

  attributes(:id, :phone, :city, :deleted_at, name: { type: :string })
end
