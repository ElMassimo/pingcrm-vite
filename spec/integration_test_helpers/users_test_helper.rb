# frozen_string_literal: true

class UsersTestHelper < BaseTestHelper
  # Aliases: Semantic aliases for locators, can be used in most DSL methods.

  # Finders: A convenient way to get related data or nested elements.

  # Actions: Encapsulate complex actions to provide a cleaner interface.
  def visit_new
    visit_page(:new_user)
  end

  def visit_edit(user)
    visit_page(:user, user:)
  end

  def create_user(first_name:, last_name:, email:)
    click_on("Create User")
    fill_in("First name:", with: first_name)
    fill_in("Last name:", with: last_name)
    fill_in("Email:", with: email)
    click_on("Create User")
  end

  def edit_user(email:, with:)
    find(:table_row, {"Email" => email}).find(:link, match: :first).click
    fill_in("First name:", with: with.fetch(:first_name))
    click_on("Update User")
  end

  def delete
    accept_confirm { click_on("Delete User") }
  end

  def search_for(value)
    fill_in("search", with: value)
  end

  def include_deleted_users
    click_on("Filter")
    select("With Trashed", from: "Trashed:")
    select("User", from: "Role:")
  end

  # Assertions: Check on element properties, used with `should` and `should_not`.
  def see_heading
    have_heading("Users")
  end

  def have_rows(count)
    have(:table_row, {}, count:) { |row| row.has_link?(wait: 0) }
  end

  def have_users(*users)
    have(:table, with_rows: users.map { |user| {"Name" => user.name, "Email" => user.email} })
  end

  def have_user(name: nil, email: nil)
    cells = {"Name" => name, "Email" => email}.compact
    have(:table_row, cells)
  end

  def see_create_action
    have_button("Create User")
  end

  def see_update_action
    have_button("Update User")
  end

  def see_delete_action
    have_button("Delete User")
  end

  def have_updated_first_name(first_name)
    have_field("First name:", with: first_name)
  end

  def have_forbidden
    have_text("Forbidden")
  end

  # Background: Helpers to add/modify/delete data in the database or session.
  def given_user(account:, owner: false, **attributes)
    create(:user, account:, owner:, **attributes)
  end

  def given_users(account:, count:)
    Array.new(count) { create(:user, account:) }.sort_by(&:name)
  end

  def delete_record(user)
    user.soft_delete!
  end
end
