require 'test_helper'

class OrganizationsQueryTest < ActiveSupport::TestCase
  test 'searches and orders active organizations' do
    account = create(:account)
    matching = create(:organization, account:, name: 'Analytical Engines')
    create(:organization, account:, name: 'Compiler Company')
    create(:organization, account:, name: 'Deleted Engines', deleted_at: Time.current)

    results = OrganizationsQuery.wrap(account.organizations)
                                .search(search: 'engine', trashed: nil)
                                .alphabetically

    assert_equal [matching], results.to_a
  end
end
