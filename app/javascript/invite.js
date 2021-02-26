$(function() {
    $('.group').change(function() {
      $.ajax({
        url: "/users/add_user_to_group",
        type: "GET",
        data: { user_id: $(this).attr('id'), group_id: $(this).has('option:selected').val() }
      });
      console.log( 'こんにちわ' );
        $(this).children('option:selected').remove();
    });
  });