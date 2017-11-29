$(function() {
  'use strict';

  $('[data-delate-checked').on('click', '.delatable', function() {
    var self = $(this),
        parent = self.closest('[data-delate-checked]'),
        userId = parent.data("user-id"),
        notification_type = 'delate_ok',
        url = parent.data("url"),
        data = {
          receiver_id: userId,
          notification_type: notification_type
        }

    _notify(url, data);
  });

  function _notify(aUrl, aData) {
    $.ajax({
      type: 'POST',
      dataType: 'JSON',
      data: aData,
      url: aUrl,
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
      success: function(data) {
        toastr.success("Notificação enviada com sucesso!");
      }
    });
  }
});
