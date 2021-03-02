import consumer from "./consumer"



const chatChannel = consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data['user_id'] == $('#user_group').data('user_id')) {
      $('#new-message').append('<span class="chat-right">'+data['message']+'</span>');
    } else {
      $('#new-message').append('<span class="chat-left">'+data['message']+'</span>');
    }
  },

  speak: function() {
    return this.perform('speak', {message: message});
  },

  create(message) {
    const user_group = $('#user_group').data()
    return this.perform('create', {
      message: message,
      user_group: user_group
    })
  }
});

$(document).on('keypress', '#message-form', function(e) {
  if (e.keyCode === 13 && e.target.value !== "") {
    chatChannel.create(e.target.value);
    e.target.value = '';
  }
})