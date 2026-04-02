# frozen_string_literal: true

# Public: Used in the edit page.
class OrganizationEditSerializer < BaseSerializer
  attributes(
    :id,
    :name,
    :email,
    :phone,
    :address,
    :city,
    :region,
    :country,
    :postal_code,
    :deleted_at
  )
end
