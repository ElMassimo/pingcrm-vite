class DashboardController < ApplicationController
  def index
    render_page(
      repo: Settings.repo,
      release: Settings.release,
    )
  end
end
