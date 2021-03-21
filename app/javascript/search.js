$(document).on('turbolinks:load', function () {
  $('#search').submit(function() {
    if($('#search_area').val() == "") {
      return false;
    }
  });
});