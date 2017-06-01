//= require views/shared/index
//= require components/ciner_tipsy
//= require views/shared/reactions

$(function() {
  'use strict';

  var broadcastReactions = $(".broadcast-reaction");

  var arrayLength = broadcastReactions.length;
  for (var i = 0; i < arrayLength; i++) {
    (new Reactions()).bindReactions($(broadcastReactions[i]));
  }

  $(document).on('click', '[data-show]', function() {
    var self = $(this),
        url = self.data('url');

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: url,
      success: function(data) {
        $('#broadcastModal .modal-dialog').html(data);
        $('#broadcastModal').modal('show');
      }
    });
  });
});
