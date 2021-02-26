class UsersController < ApplicationController
  def index
    @users = User.all
    @groups = current_user.groups
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def add_user_to_group
    GroupUser.create(user_id: params[:user_id], group_id: params[:group_id], permit: false)
  end
end
