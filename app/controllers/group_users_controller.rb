class GroupUsersController < ApplicationController
  def destroy
    group = Group.find(params[:group_id])
    group.users.delete(current_user)
    redirect_to root_path
  end

  def participate
    group_user = GroupUser.find_by(user_id: current_user.id, group_id: params[:group_id])
    group_user.update(permit: true)
    redirect_to group_chats_path(params[:group_id])
  end
end