# frozen_string_literal: true

class UserFormSerializer < BaseSerializer
  object_as :user

  attributes(
    :email,
    :first_name,
    :last_name,
    :owner,
  )
end
