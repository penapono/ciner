$(document).ready(function() {
  $('[data-friendship-action]').on('click', 'button.btn.btn-login', function() {
    var self = $(this),
        friendship = self.closest('[data-friendship-action]'),
        sender_id = friendship.data('friendshipSenderId'),
        receiver_id = friendship.data('friendshipReceiverId'),
        notification_type = friendship.attr('data-friendship-action'),
        url = friendship.data('friendshipUrl'),
        button = friendship.find('span.text');

    data = {
      sender_id: sender_id,
      receiver_id: receiver_id,
      notification_type: notification_type
    }

    _action(friendship, url, data, button);
  });

  function _action(aParent, aUrl, aData, aButton) {
    $.ajax({
      type: 'POST',
      dataType: 'JSON',
      data: aData,
      url: aUrl,
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
      success: function(data) {
        aButton.html(data.text);
        aParent.attr('data-friendship-action', data.next_action);
      }
    });
  }
});
