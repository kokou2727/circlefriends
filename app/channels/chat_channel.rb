class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['group_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'chat_channel', message: data['message']
  end

  def create(data)
    chat = Chat.new(
      message: data["message"],
      user_id: data['user_group']["user_id"],
      group_id: data["user_group"]["group_id"]
    )
    if chat.save
      ActionCable.server.broadcast "chat_channel_#{params['group_id']}", message: data['message'], user_id: data['user_group']['user_id']
    end
  end
end
