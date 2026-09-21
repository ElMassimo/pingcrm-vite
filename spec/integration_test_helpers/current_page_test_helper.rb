# frozen_string_literal: true

class CurrentPageTestHelper < Capybara::TestHelper
  aliases(
    page_content: "#app",
    page_heading: "h1",
  )

  def have_heading(text)
    have(:page_heading, text:)
  end

  def have_message(text)
    have(:page_content, text:)
  end
end
