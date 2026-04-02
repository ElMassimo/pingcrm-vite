# frozen_string_literal: true

# Public: Used in users edit page.
class UserEditSerializer < BaseSerializer
  object_as :user, model: :User

  attributes(:id, :email, :first_name, :last_name, :owner, :deleted_at)

  type :string, optional: true
  def photo
    polymorphic_url(user.photo.variant(resize_to_fill: [64, 64])) if user.photo.attached?
  end
end
