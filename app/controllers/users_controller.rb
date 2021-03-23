class UsersController < ApplicationController
  before_action :authenticate_user!
  def edit
    @side_groups = Group.order("RAND()").limit(12)
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end


  def show
    @side_groups = Group.order("RAND()").limit(12)
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def add_user_to_group
    unless GroupUser.exists?(user_id: params[:user_id], group_id: params[:group_id])
      GroupUser.create(user_id: params[:user_id], group_id: params[:group_id], permit: false)
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :image, :profile, :job, :twitter, :facebook, :youtube, :line, :instagram)
  end
end
