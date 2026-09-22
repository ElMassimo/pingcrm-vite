class UsersController < ApplicationController
  # Let CanCanCan load and authorize the instance variables
  load_and_authorize_resource

  def index
    filters = params.permit(:search, :trashed, :role).to_keywords
    @users = UsersQuery.wrap(@users).search(**filters).by_name

    render_page(
      users: UserSerializer.many(@users),
      can: {
        create_user: can?(:create, User),
      },
      filters:,
    )
  end

  def new
    render_page(
      user: UserFormSerializer.one(@user),
    )
  end

  def edit
    render_page(
      user: UserFormSerializer.one(@user),
      can: {
        edit_user: can?(:update, @user),
      },
    )
  end

  def create
    if @user.update(user_params)
      redirect_to_index @user, notice: "User created."
    else
      redirect_to_new @user, unprocessable: true
    end
  end

  def update
    if @user.demo?
      redirect_to_edit @user, alert: "Updating the demo user is not allowed."
      return
    end

    if @user.update(user_params)
      redirect_to_edit @user, notice: "User updated."
    else
      redirect_to_edit @user, unprocessable: true
    end
  end

  def destroy
    if @user.demo?
      redirect_to_edit @user, alert: "Deleting the demo user is not allowed."
      return
    end

    if @user.soft_delete
      redirect_to_edit @user, notice: "User deleted."
    else
      redirect_to_edit @user, alert: "User cannot be deleted!"
    end
  end

  def restore
    if @user.restore
      redirect_to_edit @user, notice: "User restored."
    else
      redirect_to_edit @user, alert: "User cannot be restored!"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.expect(
      user: %i[first_name last_name email owner password photo],
    ).tap do |p|
      p.delete(:photo) if p[:photo].blank?
    end
  end
end
