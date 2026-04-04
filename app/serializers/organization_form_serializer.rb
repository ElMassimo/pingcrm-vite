# frozen_string_literal: true

class OrganizationFormSerializer < BaseSerializer
  object_as :organization

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
    :deleted_at,
  )
end
