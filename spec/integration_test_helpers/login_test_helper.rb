# frozen_string_literal: true

class LoginTestHelper < BaseTestHelper
  # Aliases: Semantic aliases for locators, can be used in most DSL methods.

  # Finders: A convenient way to get related data or nested elements.

  # Actions: Encapsulate complex actions to provide a cleaner interface.
  def log_in(user, password: user.password)
    visit_page(:login)
    fill_in("Email", with: user.email)
    fill_in("Password", with: password)
    click_on("Login")
  end

  def log_out
    click_on("John Doe")
    click_on("Logout")
  end

  def follow_contacts
    click_on("Contacts")
  end

  # Assertions: Check on element properties, used with `should` and `should_not`.
  def have_dashboard
    have_text("Hey there!")
  end

  def have_invalid_credentials_message
    have_text(I18n.t("devise.failure.invalid"))
  end

  # Background: Helpers to add/modify/delete data in the database or session.
  def given_owner
    account = create(:account)
    create(:user, account:, owner: true)
  end

  def expire_session_for(user)
    sign_out(user)
  end
end
