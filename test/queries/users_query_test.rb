require 'test_helper'

class UsersQueryTest < ActiveSupport::TestCase
  test 'searches and filters users by role' do
    account = create(:account)
    owner = create(:user, account:, owner: true, first_name: 'Ada', last_name: 'Lovelace')
    create(:user, account:, owner: false, first_name: 'Grace', last_name: 'Hopper')
    create(:user, account:, owner: true, first_name: 'Ada', last_name: 'Byron', deleted_at: Time.current)

    results = UsersQuery.wrap(account.users)
                        .search(search: 'ada', trashed: nil, role: 'owner')
                        .alphabetically

    assert_equal [owner], results.to_a
  end
end
