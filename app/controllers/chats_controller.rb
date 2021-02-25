class ChatsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @chat = Chat.new
    @chats = @group.chats.includes(:user)
  end

  def create
    @group = Group.find(params[:group_id])
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to group_chats_path(@group)
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end