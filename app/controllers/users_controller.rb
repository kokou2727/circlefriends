class UsersController < ApplicationController
  def index
    @users = User.all
    @groups = current_user.groups
  end

  def edit
    user = User.find(params[:id])
    @image = user.user_icon
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def add_user_to_group
    GroupUser.create(user_id: params[:user_id], group_id: params[:group_id], permit: false)
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :user_icon, :profile)
  end
end
