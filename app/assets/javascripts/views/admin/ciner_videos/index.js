$(document).ready(function() {
  $('[data-change-status]').on('click', 'button', function() {
    var self = $(this),
        id = self.data('ciner-video-id'),
        url = "/admin/ciner_videos/"+ id +"/change_status";

    $.ajax({
      type: 'PUT',
      dataType: 'json',
      url: url,
      success: function(data) {
        self.html(data.text);
      }
    });
  });
});
