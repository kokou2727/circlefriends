class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    chat = Chat.new(
      message: data["message"],
      user_id: data['user_group']["user_id"],
      group_id: data["user_group"]["group_id"]
    )
    @user = User.find(data['user_group']["user_id"])
    if chat.save
      chat_date = chat.created_at.strftime("%p %I:%M")
      if @user.image.attached?
        user_image = Rails.application.routes.url_helpers.rails_blob_path(@user.image, only_path: true)
      else
        user_image = "/assets/profile.png"
      end
      ActionCable.server.broadcast "chat_channel", message: data['message'], user_id: data['user_group']['user_id'], group_id: data["user_group"]["group_id"], user_name: @user.name, user_image: user_image, chat_date: chat_date
    end
  end
end
