# frozen_string_literal: true

require "features_helper"

RSpec.feature "Authentication", test_helpers: %i[login] do
  let(:user) { login.given_owner }

  scenario "rejecting invalid credentials, then logging in and out" do
    login.log_in(user, password: "invalid")
    login.should.have_invalid_credentials_message

    login.log_in(user)
    login.should.have_dashboard

    login.log_out
    login.should.see_login_page
  end

  scenario "redirecting expired Inertia sessions to login" do
    login.sign_in_as(user)
    login.visit_page(:organizations)
    login.expire_session_for(user)
    login.follow_contacts

    login.should.see_login_page
    login.should.be_in_page(:login)
  end
end
