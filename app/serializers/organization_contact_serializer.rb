# frozen_string_literal: true

# Public: Used in organizations edit page contacts table.
class OrganizationContactSerializer < BaseSerializer
  object_as :contact

  attributes(:id, :name, :phone, :city, :deleted_at)
end
