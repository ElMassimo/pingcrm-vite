# frozen_string_literal: true

class NavigationTestHelper < Capybara::TestHelper
  def visit_page(page_alias, **options)
    visit(path_for(page_alias, **options))
  end

  def be_in_page(page_alias, **options)
    have_current_path(path_for(page_alias, **options))
  end

  private

  def path_for(page_alias, **options)
    routes = Rails.application.routes.url_helpers

    case page_alias
    when :login then routes.new_user_session_path
    when :dashboard then routes.root_path
    when :contacts then routes.contacts_path
    when :new_contact then routes.new_contact_path
    when :contact then routes.edit_contact_path(options.fetch(:contact))
    when :organizations then routes.organizations_path
    when :organization then routes.edit_organization_path(options.fetch(:organization))
    when :users then routes.users_path
    when :new_user then routes.new_user_path
    when :user then routes.edit_user_path(options.fetch(:user))
    else raise ArgumentError, "Unknown page alias: #{page_alias.inspect}"
    end
  end
end
