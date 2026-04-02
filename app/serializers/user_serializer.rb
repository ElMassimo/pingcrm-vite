# frozen_string_literal: true

# Public: Used in the index page.
class UserSerializer < BaseSerializer
  object_as :user, model: :User

  attributes(:id, :email, :owner, :deleted_at, name: { type: :string })

  type :string, optional: true
  def photo
    polymorphic_url(user.photo.variant(resize_to_fill: [64, 64])) if user.photo.attached?
  end

  type :object
  def can
    { edit_user: can?(:edit, user) }
  end
end
