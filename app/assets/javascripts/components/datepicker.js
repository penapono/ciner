$(function() {
  'use strict';

  // Initialize datepickers
  $('input.datepicker').datepicker();
  $('input.datepicker').mask('99/99/9999');

  // When add a field, datepicker is initialized
  $('form').on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.find('input.datepicker').datepicker();
    insertedItem.find('input.datepicker').mask('99/99/9999');
  });
});
