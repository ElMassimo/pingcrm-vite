# frozen_string_literal: true

require "features_helper"

RSpec.feature "Users", test_helpers: %i[users] do
  let(:account) { create(:account) }
  let!(:owner) { users.given_user(account:, owner: true) }
  let!(:user) { users.given_user(account:) }

  scenario "listing and searching users" do
    records = users.given_users(account:, count: 15)
    users.sign_in_as(user)

    users.visit_page
    users.should.see_heading
    users.should.have_rows(17)
    users.should.have_users(*records)

    records.first.update!(last_name: "Turing")
    users.search_for("Turing")
    users.should.have_rows(1)
    users.should.have_user(name: records.first.name)
  end

  scenario "an owner creates, edits, and deletes a user" do
    users.sign_in_as(owner)

    users.visit_page
    users.create_user(first_name: "Jonathan", last_name: "Smith", email: "john@smith.com")
    users.should.have_user(name: "Smith, Jonathan", email: "john@smith.com")

    users.edit_user(email: "john@smith.com", with: {first_name: "Jon"})
    users.should.have_updated_first_name("Jon")

    users.delete
    users.should.see_heading
    users.should_not.have_user(email: "john@smith.com")
  end

  scenario "a non-owner cannot create, edit, or delete users" do
    users.sign_in_as(user)

    users.visit_page
    users.should_not.see_create_action

    users.visit_new
    users.should.have_forbidden

    users.visit_edit(user)
    users.should_not.see_update_action
    users.should_not.see_delete_action
  end

  scenario "including deleted users through the filters" do
    users.delete_record(user)
    users.sign_in_as(owner)

    users.visit_page
    users.should_not.have_user(email: user.email)

    users.include_deleted_users
    users.should.have_user(email: user.email)
  end

  scenario "requiring authentication" do
    users.visit_page

    users.should.see_login_page
    users.should.be_in_page(:login)
  end
end
