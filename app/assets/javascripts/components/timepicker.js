$(function() {
  'use strict';

  // Initialize timepickers
  $('input.timepicker').mask('99:99');

  // When add a field, timepicker is initialized
  $('form').on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.find('input.timepicker').mask('99:99');
  });
});
