$(document).on('turbolinks:load', function () {
  $('.jscroll').on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $('.jscroll').height() + $('.jscroll').scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
          $('.jscroll').jscroll({
            loadingHtml: '<div class="loading"><i class="fas fa-spinner"></i></div>',
            contentSelector: '.post-scroll',
            nextSelector: 'span.next:last a'
          });
    }
  });
});