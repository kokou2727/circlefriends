import consumer from "./consumer"
$(document).on('turbolinks:load', function() {
  if(document.URL.match(/chats/)){
    $(".chats-main").scrollTop($('.chats-main')[0].scrollHeight);
  }
});
    const chatChannel = consumer.subscriptions.create("ChatChannel", {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        let message = data['message'].replace(/\n|\r\n|\r/g, '<br>');
        if (data['user_id'] == $('#user_group').data('user_id')) {
          let chat_content = `
          <div class='chat'>
          <div class='chat-right'>
            <div style='display: flex;  align-items: flex-end'>
                <span class="date">
                ${data['chat_date']}
                </span>
              <div class='chat-message' style='border-radius: 16px 0 16px 16px'>
                <span class='message-content'>
                  <p>${message}</p>
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
                <div style='display: flex; align-items: flex-end'>
                  <div class='chat-message' style='border-radius: 0 16px 16px 16px; background-color: rgb(255, 255, 255);'>
                    <span class='message-content'>
                      <p>${message}</p>
                    </span>
                  </div>
                    <span class="date">
                    ${data['chat_date']}
                    </span>
                </div>
              </div>
            </div>`
            $('#new-message').append(chat_content);
        }
        $('.chats-main').animate({ scrollTop: $('.chats-main')[0].scrollHeight});
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
        if ( e.keyCode === 13 && (e.shiftKey === true || e.ctrlKey === true || e.altKey === true || e.optionKey === true || e.commandKey === true ) ) {
          e.target.value = e.target.value + "\n";
          return false
        }
        if (e.keyCode === 13 && e.target.value !== "" ) {
        chatChannel.create(e.target.value);
        e.target.value = '';
        e.preventDefault();
      }
      $('#message-send').on('click',function() {
        chatChannel.create(e.target.value);
        e.target.value = '';
        e.preventDefault();
      });
    })