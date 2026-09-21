# frozen_string_literal: true

require "features_helper"

RSpec.feature "Contacts", test_helpers: %i[contacts] do
  let(:account) { create(:account) }
  let(:owner) { create(:user, account:, owner: true) }

  before { contacts.sign_in_as(owner) }

  scenario "listing, paginating, and searching contacts" do
    records = contacts.given_contacts(account:, count: 15)

    contacts.visit_index
    contacts.should.have_index
    contacts.should.have_rows(10)
    contacts.should.have_contacts(*records.first(10))

    contacts.next_page
    contacts.should.have_rows(5)
    contacts.should.have_contacts(*records.last(5))

    records.first.update!(last_name: "AAA")
    contacts.search_for("AAA")
    contacts.should.have_rows(1)
    contacts.should.have_contact("AAA")
  end

  scenario "including deleted contacts through the filter" do
    records = contacts.given_contacts(account:, count: 5)
    contacts.delete_record(records.first)

    contacts.visit_index
    contacts.should.have_rows(4)

    contacts.include_deleted
    contacts.should.have_rows(5)
  end

  scenario "creating, editing, and deleting a contact" do
    contacts.visit_index
    contacts.start_creating
    contacts.should.have_create_form

    contacts.submit_create
    contacts.should.have_form_errors(2)

    contacts.submit_create(first_name: "Jane", last_name: "Doe")
    contacts.should.have_contact("Doe, Jane")

    contacts.edit_contact("Doe, Jane")
    contacts.update_name(first_name: "Janet", last_name: "Doe")
    contacts.should.have_updated_name(first_name: "Janet", last_name: "Doe")

    contacts.delete
    contacts.should.have_index
    contacts.should_not.have_contact("Doe, Janet")
  end

  scenario "requiring authentication" do
    contacts.sign_out(owner)
    contacts.visit_index

    contacts.should.have_login
    contacts.should.be_in_page(:login)
  end
end
