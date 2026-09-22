# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrganizationsQuery do
  it "searches and orders active organizations" do
    account = create(:account)
    matching = create(:organization, account:, name: "Analytical Engines")
    create(:organization, account:, name: "Compiler Company")
    create(:organization, account:, name: "Deleted Engines", deleted_at: Time.current)

    results = described_class.wrap(account.organizations)
      .search(search: "engine", trashed: nil)
      .by_name

    expect(results).to contain_exactly(matching)
  end
end
