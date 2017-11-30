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
        },
        delateUrl = parent.data('delate-url');

    _update_delate(self, delateUrl);
    _notify(url, data);
  });

  function _update_delate(aParent, aUrl) {
    var data = {
      delate: {
        status: "answered"
      }
    }

    $.ajax({
      type: 'PUT',
      dataType: 'JSON',
      data: data,
      url: aUrl,
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
      success: function(data) {
        aParent.fadeOut(500, function(){ $(this).remove();});
      }
    });
  }


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
