//= require components/ciner_slider

$(document).ready(function() {
  $('[data-friendship-action]').on('click', 'button.btn.btn-login', function() {
    var self = $(this),
        friendship = self.closest('[data-friendship-action]'),
        sender_id = friendship.data('friendshipSenderId'),
        receiver_id = friendship.data('friendshipReceiverId'),
        notification_type = friendship.data('friendshipAction'),
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
        aParent.data('action', data.action);
      }
    });
  }

  $(document).on('click', '.shelf', function() {
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
    var self = $(this);

    $('.datepicker').mask('99/99/9999');
    $('.money').mask('000.000.000.000.000,00', {reverse: true});
    $('select').select2({
      theme: "bootstrap",
      minimumResultsForSearch: 50
    });

    self.on('click', '[data-brother-locker] input[type="checkbox"]', function(){
      var self  = $(this),
          status = self.prop('checked'),
          lockerParent = self.closest('[data-brother-locker]'),
          lockerId = lockerParent.data('brother-locker'),
          brothers = self.closest('form').find("[data-brother-locked='" + lockerId + "'] input");

      if (status) {
        brothers.prop('disabled', true);
      }else{
        brothers.prop('disabled', false);
      }
    });

    self.on('click', '[data-brother-unlocker] input[type="checkbox"]', function(){
      var self  = $(this),
          status = self.prop('checked'),
          unlockerParent = self.closest('[data-brother-unlocker]'),
          unlockerId = unlockerParent.data('brother-unlocker'),
          brothers = self.closest('form').find("[data-brother-unlocked='" + unlockerId + "'] input");

      if (status) {
        brothers.prop('disabled', false);
      }else{
        brothers.prop('disabled', true);
      }
    });
  });

  var container_favorite = $('[data-slider-favorites]');
  _sliderize(container_favorite);

  var container_watched = $('[data-slider-watched]');
  _sliderize(container_watched);
});

$(window).resize(function() {
  var container_favorite = $('[data-slider-favorites]');
  _sliderize(container_favorite);

  var container_watched = $('[data-slider-watched]');
  _sliderize(container_watched);
});

function _sliderize(aContainer) {
  var cinerSlider = new CinerSlider();
  cinerSlider.sliderize(aContainer);
}

