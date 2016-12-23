$(function() {
  'use strict';

  var timer = 0;
  var t0 = 0;
  var t1 = 0;


  $('#terms-link').click(function (event) {
    t0 = Date.now();
    showTerms();
    event.preventDefault(); // Prevent link from following its href
  });

  function showTerms(){
    $('.overlay-bg').show();
    $('.terms-container').show();
  }

  $('#close-terms').click(function (event) {
    $('.overlay-bg').hide();
    $('.terms-container').hide();
    t1 = Date.now();
    timer = timer + (t1 - t0);
    event.preventDefault();
  });

  $('.overlay-bg').click(function (event) {
    $('.overlay-bg').hide();
    $('.terms-container').hide();
    t1 = Date.now();
    timer = timer + (t1-t0);
    event.preventDefault();
  });

  $('form').on('change', "[data-terms] input", function (event) {
    var self = $(this),
        checked = self.prop('checked'),
        dataTerms = self.closest('[data-terms]'),
        comboTerms = dataTerms.find('#user_terms_of_use');

    comboTerms.prop('checked', checked);
  });
});
