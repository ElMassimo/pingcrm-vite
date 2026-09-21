# frozen_string_literal: true

class BaseTestHelper < Capybara::TestHelper
  use_test_helpers(:navigation)

  # Aliases: Semantic aliases for locators, can be used in most DSL methods.
  aliases(
    page_content: "#app",
    page_heading: "h1",
  )

  # Finders: A convenient way to get related data or nested elements.

  # Actions: Encapsulate complex actions to provide a cleaner interface.
  delegate :visit_page, to: :navigation

  # Assertions: Check on element properties, used with `should` and `should_not`.
  def have_heading(text)
    have(:page_heading, text:)
  end

  def have_text(text)
    have(:page_content, text:)
  end

  def see_login_page
    have_heading("Welcome Back!")
  end

  def be_in_page(page_alias, **options)
    navigation.be_in_page(page_alias, **options)
  end

  # Background: Helpers to add/modify/delete data in the database or session.
  delegate_to_test_context(:create, :sign_in, :sign_out)

  def sign_in_as(user)
    sign_in(user)
  end
end
