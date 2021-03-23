$(document).on('turbolinks:load', function() {
  if(document.URL.match(/invite_index/)){
    document.getElementById("invite-btn").onclick = function() {
      $('input:checkbox[name="group_invite_check"]:checked').each(function() {
        $.ajax({
          url: "/users/add_user_to_group",
          type: "GET",
          data: { user_id: $(this).attr('user_id'), group_id: $(this).attr('group_id') }
        });
      });
    };
  };
});