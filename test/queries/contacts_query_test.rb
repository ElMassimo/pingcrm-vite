require 'test_helper'

class ContactsQueryTest < ActiveSupport::TestCase
  test 'searches, filters trashed records, and orders contacts' do
    account = create(:account)
    organization = create(:organization, account:, name: 'Analytical Engines')
    matching = create(:contact, account:, organization:, first_name: 'Ada', last_name: 'Lovelace')
    create(:contact, account:, first_name: 'Grace', last_name: 'Hopper')
    trashed = create(:contact, account:, first_name: 'Ada', last_name: 'Byron', deleted_at: Time.current)

    query = ContactsQuery.wrap(account.contacts)

    assert_equal [matching], query.search(search: 'engine', trashed: nil).by_name.to_a
    assert_equal [trashed, matching], query.search(search: 'ada', trashed: 'with').by_name.to_a
    assert_equal [trashed], query.search(search: nil, trashed: 'only').to_a
  end
end
