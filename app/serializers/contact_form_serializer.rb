# frozen_string_literal: true

# Public: Used to populate the contact edit form.
class ContactFormSerializer < BaseSerializer
  object_as :contact

  attributes(
    :id,
    :first_name,
    :last_name,
    :organization_id,
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
