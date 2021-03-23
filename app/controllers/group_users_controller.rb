class GroupUsersController < ApplicationController
  before_action :authenticate_user!
  def destroy
    group = Group.find(params[:group_id])
    group.users.delete(current_user)
    redirect_to root_path
  end

  def participate
    if GroupUser.exists?(user_id: current_user.id, group_id: params[:group_id], permit: false)
      group_user = GroupUser.find_by(user_id: current_user.id, group_id: params[:group_id])
      group_user.update(permit: true)
      redirect_to group_chats_path(params[:group_id])
    else
      redirect_to root_path
    end
  end

  def self_participate
    if GroupUser.exists?(user_id: params[:user_id], group_id: params[:group_id], permit: false)
      group_user = GroupUser.find_by(user_id: params[:user_id], group_id: params[:group_id])
      group_user.update(permit: true)
    end
    unless GroupUser.exists?(user_id: params[:user_id], group_id: params[:group_id])
      GroupUser.create(user_id: params[:user_id], group_id: params[:group_id], permit: true)
    end
    redirect_to group_chats_path(params[:group_id])
  end
end