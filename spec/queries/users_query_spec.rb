# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersQuery do
  it "searches and filters users by role" do
    account = create(:account)
    owner = create(:user, account:, owner: true, first_name: "Ada", last_name: "Lovelace")
    create(:user, account:, owner: false, first_name: "Grace", last_name: "Hopper")
    create(:user, account:, owner: true, first_name: "Ada", last_name: "Byron", deleted_at: Time.current)

    results = described_class.wrap(account.users)
      .search(search: "ada", trashed: nil, role: "owner")
      .by_name

    expect(results).to contain_exactly(owner)
  end
end
