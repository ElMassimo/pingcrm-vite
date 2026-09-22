# frozen_string_literal: true

# Public: Used to populate the user new/edit forms.
class UserFormSerializer < BaseSerializer
  object_as :user

  attributes(
    :id,
    :email,
    :first_name,
    :last_name,
    :owner,
    :deleted_at,
  )

  type :string
  def photo
    polymorphic_url(user.photo.variant(resize_to_fill: [64, 64])) if user.photo.attached?
  end
end
