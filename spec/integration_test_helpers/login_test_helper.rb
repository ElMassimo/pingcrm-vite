# frozen_string_literal: true

class LoginTestHelper < BaseTestHelper
  def given_owner
    account = create(:account)
    create(:user, account:, owner: true)
  end

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

  def expire_session_for(user)
    sign_out(user)
  end

  def follow_contacts
    click_on("Contacts")
  end

  def have_dashboard
    current_page.have_message("Hey there!")
  end

  def have_login
    current_page.have_heading("Welcome Back!")
  end

  def have_invalid_credentials_message
    current_page.have_message(I18n.t("devise.failure.invalid"))
  end
end
