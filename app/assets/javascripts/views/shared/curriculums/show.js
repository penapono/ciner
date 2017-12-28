$(function(){
  'use strict';

  $('[data-contact]').on('click', '.btn', function() {
    var self = $(this),
        parent = self.closest('[data-contact]'),
        url = parent.data("url"),
        sender_id = self.data('sender-id'),
        receiver_id = self.data('receiver-id'),
        notification_type = self.data('notification-type'),
        data = {
          sender_id: sender_id,
          receiver_id: receiver_id,
          notification_type: notification_type
        };

    _contact(url, data);
  });

  function _contact(aUrl, aData) {
    $.ajax({
      type: 'POST',
      dataType: 'JSON',
      url: aUrl,
      data: aData,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data) {
        toastr.info("O profissional será informado de seu interesse em contatá-lo!");
      }
    });
  }
});
