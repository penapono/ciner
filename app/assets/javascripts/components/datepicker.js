$(function() {
  'use strict';

  // Initialize datepickers
  $('input.datepicker').datepicker();

  // When add a field, datepicker is initialized
  $('form').on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.find('input.datepicker').datepicker();
  });
});
