# frozen_string_literal: true

class OrganizationsTestHelper < BaseTestHelper
  aliases(organization_form: "form")

  def given_organizations(account:, count:)
    Array.new(count) { create(:organization, account:) }.sort_by(&:name)
  end

  def delete_record(organization)
    organization.soft_delete!
  end

  def visit_index
    visit_page(:organizations)
  end

  def start_creating
    click_on("Create Organization")
  end

  def create_organization(name:)
    within(:organization_form) do
      fill_in("Name:", with: name)
      click_on("Create Organization")
    end
  end

  def edit_organization(name)
    find(:table_row, {"Name" => name}).click_link(name)
  end

  def update_name(name)
    fill_in("Name:", with: name)
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

  def have_index
    current_page.have_heading("Organizations")
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

  def have_create_form
    have(:organization_form)
    have_button("Create Organization")
  end

  def have_updated_name(name)
    have_field("Name:", with: name)
  end

  def have_login
    current_page.have_heading("Welcome Back!")
  end
end
