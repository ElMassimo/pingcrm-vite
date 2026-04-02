# frozen_string_literal: true

# Public: Used in the index page.
class ContactSerializer < BaseSerializer
  attributes(:id, :phone, :city, :deleted_at, name: { type: :string })

  has_one :organization, serializer: ModelSerializer
end
