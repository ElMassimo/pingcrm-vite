class UsersQuery < ApplicationQuery
  query_from User

  filter :search, ->(value) do
    value.present? ? matches_any_of(%i[first_name last_name email], value) : self
  end

  filter :role, ->(role) do
    case role
    when 'user' then where(owner: false)
    when 'owner' then where(owner: true)
    else self
    end
  end

  def by_name
    order(:last_name, :first_name)
  end
end
