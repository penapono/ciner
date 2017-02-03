//= require moment
//= require bootstrap-datetimepicker
//= require ../moment/custom-pt-br

$(function() {
  'use strict';

  // Initialize timepickers
  $('input.timepicker').datetimepicker({
    format: 'HH:mm',
    locale: 'pt-BR',
    stepping: 1
  });

  // When add a field, timepicker is initialized
  $('form').on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.find('input.timepicker').datetimepicker();
  });
});
