class ChatsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @chat = Chat.new
    @chats = @group.chats.includes(:user)
    unless GroupUser.find_by(user_id: current_user.id, group_id: @group.id).permit
      redirect_to root_path
    end
  end
end
