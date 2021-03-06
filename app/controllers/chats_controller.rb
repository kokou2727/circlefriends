class ChatsController < ApplicationController
  before_action :authenticate_user!
  def index
    @side_groups = Group.order('RAND()').limit(12)
    @group = Group.find(params[:group_id])
    @chat = Chat.new
    @chats = @group.chats.includes(:user)
    redirect_to root_path unless GroupUser.find_by(user_id: current_user.id, group_id: @group.id).permit
  end
end
