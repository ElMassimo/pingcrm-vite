# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactsQuery do
  it "searches, filters trashed records, and orders contacts" do
    account = create(:account)
    organization = create(:organization, account:, name: "Analytical Engines")
    matching = create(:contact, account:, organization:, first_name: "Ada", last_name: "Lovelace")
    create(:contact, account:, first_name: "Grace", last_name: "Hopper")
    trashed = create(:contact, account:, first_name: "Ada", last_name: "Byron", deleted_at: Time.current)

    query = described_class.wrap(account.contacts)

    expect(query.search(search: "engine", trashed: nil).by_name).to contain_exactly(matching)
    expect(query.search(search: "ada", trashed: "with").by_name).to eq([trashed, matching])
    expect(query.search(search: nil, trashed: "only")).to contain_exactly(trashed)
  end
end
