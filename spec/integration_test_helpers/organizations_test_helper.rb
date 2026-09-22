# frozen_string_literal: true

class OrganizationsTestHelper < BaseTestHelper
  # Aliases: Semantic aliases for locators, can be used in most DSL methods.
  aliases(organization_form: "form")

  # Finders: A convenient way to get related data or nested elements.

  # Actions: Encapsulate complex actions to provide a cleaner interface.
  def create_organization(name:)
    click_on("Create Organization")
    within(:organization_form) do
      fill_in("Name:", with: name)
      click_on("Create Organization")
    end
  end

  def edit_organization(name, with:)
    find(:table_row, {"Name" => name}).click_link(name)
    fill_in("Name:", with: with.fetch(:name))
    click_on("Update Organization")
  end

  def delete
    accept_confirm { click_on("Delete Organization") }
  end

  def next_page
    click_on("Next")
  end

  def search_for(value)
    fill_in("search", with: value)
  end

  def include_deleted
    click_on("Filter")
    select("With Trashed", from: "Trashed:")
  end

  # Assertions: Check on element properties, used with `should` and `should_not`.
  def see_heading
    have_heading("Organizations")
  end

  def have_rows(count)
    have(:table_row, {}, count:) { |row| row.has_link?(wait: 0) }
  end

  def have_organizations(*organizations)
    have(:table, with_rows: organizations.map { |organization| {"Name" => organization.name} })
  end

  def have_organization(name)
    have(:table_row, {"Name" => name})
  end

  def have_updated_name(name)
    have_field("Name:", with: name)
  end

  # Background: Helpers to add/modify/delete data in the database or session.
  def given_organizations(account:, count:)
    Array.new(count) { create(:organization, account:) }.sort_by(&:name)
  end

  def delete_record(organization)
    organization.soft_delete!
  end
end
