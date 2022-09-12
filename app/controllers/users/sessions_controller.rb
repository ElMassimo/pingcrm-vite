class Users::SessionsController < Devise::SessionsController
  # GET /login
  def new
    render inertia: 'auth/login', props: {}
  end

  # POST /login
  def create # rubocop:disable Lint/UselessMethodDefinition
    super
  end

  # DELETE /logout
  def destroy # rubocop:disable Lint/UselessMethodDefinition
    super
  end
end
