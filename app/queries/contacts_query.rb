class ContactsQuery < ApplicationQuery
  query_from Contact

  filter :search, ->(value) do
    next self if value.blank?

    matches_any_of(
      [
        :first_name,
        :last_name,
        :email,
        Organization.arel_table[:name],
      ],
      value,
    ).left_joins(:organization)
  end

  def alphabetically
    order(:last_name, :first_name)
  end
end
