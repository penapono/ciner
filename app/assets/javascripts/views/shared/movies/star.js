$(function() {
  'use strict';

  $('.rating').off('click');

  $(document).on('click', '.rating .star .glyphicon.glyphicon-star', function() {
    var self = $(this),
        stars = $('.rating .star .glyphicon.glyphicon-star'),
        note = 0;

    for (var i = 0; i < stars.length; i++) {
      if (self.is($(stars[i]))) {
        note = i + 1;
      }
    }

    // $.ajax({
    //   type: 'GET',
    //   dataType: 'html',
    //   url: url,
    //   success: function(data) {
    //     $('#collectionModal .modal-dialog').html(data);
    //     $('#collectionModal').modal('show');
    //   }
    // });
  });
});
