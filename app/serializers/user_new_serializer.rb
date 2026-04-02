# frozen_string_literal: true

# Public: Used in users new page.
class UserNewSerializer < BaseSerializer
  object_as :user, model: :User

  attributes(:email, :first_name, :last_name, :owner)
end
