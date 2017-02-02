//= require components/ciner_select2

$(function() {
  'use strict';

  // Scroll to filters
  var filtered = $('#filtered').val();

  if (filtered === "true") {
    $('html, body').animate({ scrollTop: $('#filters').offset().top }, 'slow');
  }
});
