class OrganizationsQuery < ApplicationQuery
  query_from Organization

  filter :search, ->(value) { value.present? ? where(matches(:name, value)) : self }

  def by_name
    order(:name)
  end
end
