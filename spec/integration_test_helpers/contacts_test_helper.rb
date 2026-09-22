# frozen_string_literal: true

class ContactsTestHelper < BaseTestHelper
  # Aliases: Semantic aliases for locators, can be used in most DSL methods.

  # Finders: A convenient way to get related data or nested elements.

  # Actions: Encapsulate complex actions to provide a cleaner interface.
  def visit_index
    visit_page(:contacts)
  end

  def create_contact(first_name:, last_name:)
    click_on("Create Contact")
    fill_in("First name:", with: first_name)
    fill_in("Last name:", with: last_name)
    click_on("Create Contact")
  end

  def edit_contact(name, with:)
    find(:table_row, {"Name" => name}).find(:link, match: :first).click
    fill_in("First name:", with: with.fetch(:first_name))
    fill_in("Last name:", with: with.fetch(:last_name))
    click_on("Update Contact")
  end

  def delete
    accept_confirm { click_on("Delete Contact") }
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
    have_heading("Contacts")
  end

  def have_rows(count)
    have(:table_row, {}, count:) { |row| row.has_link?(wait: 0) }
  end

  def have_contacts(*contacts)
    have(:table, with_rows: contacts.map { |contact| {"Name" => contact.name} })
  end

  def have_contact(name)
    have(:table_row, {"Name" => name})
  end

  def have_updated_name(first_name:, last_name:)
    have_field("First name:", with: first_name)
    have_field("Last name:", with: last_name)
  end

  # Background: Helpers to add/modify/delete data in the database or session.
  def given_contacts(account:, count:)
    Array.new(count) { create(:contact, account:) }.sort_by(&:name)
  end

  def delete_record(contact)
    contact.soft_delete!
  end
end
