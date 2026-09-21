# frozen_string_literal: true

class BaseTestHelper < Capybara::TestHelper
  use_test_helpers(:current_page, :navigation)

  delegate_to_test_context(:create, :sign_in, :sign_out)
  delegate :visit_page, to: :navigation

  def sign_in_as(user)
    sign_in(user)
  end

  def be_in_page(page_alias, **options)
    navigation.be_in_page(page_alias, **options)
  end
end
