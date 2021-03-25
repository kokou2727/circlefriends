class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :destroy]
  def follow_index
    @side_groups = Group.order('RAND()').limit(12)
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def follower_index
    @side_groups = Group.order('RAND()').limit(12)
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  def create
    following = current_user.follow(@user)
    following.save
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
