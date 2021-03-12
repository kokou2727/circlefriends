$(document).on('turbolinks:load', function() {
  $(".hover").mouseleave(
    function () {
      $(this).removeClass("hover");
    }
  );
});