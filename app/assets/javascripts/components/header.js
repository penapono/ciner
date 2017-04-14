$(function(){
  var nav = $('.nav-container');

  $(window).scroll(function () {
    if ($(this).scrollTop() > 271) {
      nav.addClass("f-nav");
      nav.find('[data-container-full]').addClass("collapse");
      nav.find('[data-container-fixed]').removeClass("collapse");
    } else {
      nav.removeClass("f-nav");
      nav.find('[data-container-full]').removeClass("collapse");
      nav.find('[data-container-fixed]').addClass("collapse");
    }
  });
});
