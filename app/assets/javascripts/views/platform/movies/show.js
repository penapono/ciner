//= require views/shared/user_filmables

$(function() {
  'use strict';

  (new UserFilmables()).bindUserFilmables($("#user-actions"));

  $(document).on('click', '.collector', function() {
    var self = $(this),
        url = self.data('url');

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: url,
      success: function(data) {
        $('#collectionModal .modal-dialog').html(data);
        $('#collectionModal').modal('show');
      }
    });
  });

  $(document).on('click', '.edit-shelf', function() {
    var self = $(this),
        url = self.data('url');

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: url,
      success: function(data) {
        $('#collectionModal .modal-dialog').html(data);
        $('#collectionModal').modal('show');
      }
    });
  });

  $('.modal').on('show.bs.modal', function () {
    $('#collectionModal input.datepicker').mask('99/99/9999');
    $('select').select2({
      theme: "bootstrap",
      minimumResultsForSearch: 50
    });
  });
});
