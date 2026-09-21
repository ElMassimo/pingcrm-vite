# frozen_string_literal: true

# Public: Lightweight contact list used in the organization edit page (no
# nested organization, since every contact belongs to the same organization).
class ContactListSerializer < BaseSerializer
  object_as :contact

  attributes(:id, :name, :phone, :city, :deleted_at)
end
