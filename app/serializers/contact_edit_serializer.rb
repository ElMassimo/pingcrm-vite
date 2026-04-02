# frozen_string_literal: true

# Public: Used in the edit page.
class ContactEditSerializer < BaseSerializer
  attributes :id, :first_name, :last_name, :organization_id, :email, :phone, :address, :city, :region, :country, :postal_code, :deleted_at
end
