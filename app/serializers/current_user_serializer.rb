class CurrentUserSerializer < BaseSerializer
  object_as :user

  attributes(
    :id,
    :first_name,
    :last_name,
  )

  type :string
  def name
    user.account.name
  end
end
