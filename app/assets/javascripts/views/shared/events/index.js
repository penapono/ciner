//= require views/shared/index

$(function() {
  'use strict';

  $(document).on('click', '[data-show]', function() {
    var self = $(this),
        url = self.data('url');

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: url,
      success: function(data) {
        $('#contentModal .modal-dialog').html(data);
        $('#contentModal').modal('show');
      }
    });
  });
});
