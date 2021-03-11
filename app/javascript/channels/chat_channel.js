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
      let chat_content = `
      <div class='chat'>
      <div class='chat-right'>
        <div style='display: flex'>
          <div>
            <span class="date">
              
            </span>
          </div>
          <div class='chat-message' style='border-radius: 16px 0 16px 16px'>
            <span class='chat-message-content'>
            ${data['message']}
            </span>
          </div>
        </div>
      </div>
      `
     $('#new-message').append(chat_content);
    } else {
        let chat_content = `
        <div class='chat'>
          <div class='chat-icon-area'>
            <img class="post-icon" src=${data['user_image']}>
          </div>
          <div class='chat-left'>
            <span class="chat-user-name">
              ${data['user_name']}
            </span>
            </br>
            <div style='display: flex'>
              <div class='chat-message' style='border-radius: 0 16px 16px 16px; background-color: rgb(255, 255, 255);'>
                <span class='chat-message-content'>
                  ${data['message']}
                </span>
              </div>
              <div>
                <span class="date">
                
                </span>
              </div>
            </div>
          </div>
        </div>`
        $('#new-message').append(chat_content);
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

  e.preventDefault();
  if (e.keyCode === 13 && e.target.value !== "") {
    chatChannel.create(e.target.value);
    e.target.value = '';
  }
})