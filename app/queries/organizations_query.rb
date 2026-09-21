class OrganizationsQuery < ApplicationQuery
  query_from Organization

  filter :search, ->(value) { value.present? ? where(matches(:name, value)) : self }

  def alphabetically
    order(:name)
  end
end
