//= require components/ciner_slider

$(document).ready(function() {
  $('[data-friendship-action]').on('click', 'button.btn.btn-login', function() {
    var self = $(this),
        friendship = self.closest('[data-friendship-action]'),
        sender_id = friendship.data('friendshipSenderId'),
        receiver_id = friendship.data('friendshipReceiverId'),
        add = friendship.data('friendshipAdd'),
        pending = friendship.data('friendshipPending'),
        remove = friendship.data('friendshipRemove'),
        url = friendship.data('friendshipUrl'),
        text = friendship.find('span.text');

    if (add) {
      text.html("Aguardando");
      friendship.data("friendshipAdd", false);
      friendship.data("friendshipPending", true);
      friendship.data("friendshipRemove", false);
    }
    else {
      if (pending) {
        text.html('Desfazer amizade');
        friendship.data("friendshipAdd", false);
        friendship.data("friendshipPending", false);
        friendship.data("friendshipRemove", true);
      }
      else {
        if (remove) {
          text.html('Adicionar amigo');
          friendship.data("friendshipAdd", true);
          friendship.data("friendshipPending", false);
          friendship.data("friendshipRemove", false);
        }
      }
    }

  });

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

