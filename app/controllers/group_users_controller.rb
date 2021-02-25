class GroupUsersController < ApplicationController
  def destroy
    group = Group.find(params[:group_id])
    group.users.delete(current_user)
    redirect_to root_path
  end
end