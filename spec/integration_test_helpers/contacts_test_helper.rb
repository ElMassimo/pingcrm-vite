# frozen_string_literal: true

class ContactsTestHelper < BaseTestHelper
  aliases(contact_form: "form")

  def given_contacts(account:, count:)
    Array.new(count) { create(:contact, account:) }.sort_by(&:name)
  end

  def delete_record(contact)
    contact.soft_delete!
  end

  def visit_index
    visit_page(:contacts)
  end

  def start_creating
    click_on("Create Contact")
  end

  def submit_create(first_name: nil, last_name: nil)
    fill_in("First name:", with: first_name) if first_name
    fill_in("Last name:", with: last_name) if last_name
    click_on("Create Contact")
  end

  def edit_contact(name)
    find(:table_row, {"Name" => name}).find(:link, match: :first).click
  end

  def update_name(first_name:, last_name:)
    fill_in("First name:", with: first_name)
    fill_in("Last name:", with: last_name)
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

  def have_index
    current_page.have_heading("Contacts")
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

  def have_create_form
    have(:contact_form)
    have_button("Create Contact")
  end

  def have_form_errors(count)
    current_page.have_message("There are #{count} form errors.")
  end

  def have_updated_name(first_name:, last_name:)
    have_field("First name:", with: first_name)
    have_field("Last name:", with: last_name)
  end

  def have_login
    current_page.have_heading("Welcome Back!")
  end
end
