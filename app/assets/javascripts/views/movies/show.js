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
    $('.datepicker').mask('99/99/9999');
    $('.money').mask('000.000.000.000.000,00', {reverse: true});
    $('select').select2({
      theme: "bootstrap",
      minimumResultsForSearch: 50
    });
  });
});
