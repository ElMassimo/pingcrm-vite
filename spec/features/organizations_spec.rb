# frozen_string_literal: true

require "features_helper"

RSpec.feature "Organizations", test_helpers: %i[organizations] do
  let(:account) { create(:account) }
  let(:owner) { create(:user, account:, owner: true) }

  before { organizations.sign_in_as(owner) }

  scenario "listing, paginating, and searching organizations" do
    records = organizations.given_organizations(account:, count: 15)

    organizations.visit_index
    organizations.should.have_index
    organizations.should.have_rows(10)
    organizations.should.have_organizations(*records.first(10))

    organizations.next_page
    organizations.should.have_rows(5)
    organizations.should.have_organizations(*records.last(5))

    records.first.update!(name: "Some Big Fancy Company Name")
    organizations.search_for("Some Big Fancy Company Name")
    organizations.should.have_rows(1)
    organizations.should.have_organization("Some Big Fancy Company Name")
  end

  scenario "including deleted organizations through the filter" do
    records = organizations.given_organizations(account:, count: 5)
    organizations.delete_record(records.first)

    organizations.visit_index
    organizations.should.have_rows(4)

    organizations.include_deleted
    organizations.should.have_rows(5)
  end

  scenario "creating, editing, and deleting an organization" do
    organizations.visit_index
    organizations.start_creating
    organizations.should.have_create_form

    organizations.create_organization(name: "The new organization")
    organizations.should.have_organization("The new organization")

    organizations.edit_organization("The new organization")
    organizations.update_name("The updated organization")
    organizations.should.have_updated_name("The updated organization")

    organizations.delete
    organizations.should.have_index
    organizations.should_not.have_organization("The updated organization")
  end

  scenario "requiring authentication" do
    organizations.sign_out(owner)
    organizations.visit_index

    organizations.should.have_login
    organizations.should.be_in_page(:login)
  end
end
