//= require components/ciner_slider

$(document).ready(function() {
  var container_favorite = $('[data-slider-favorites]');
  _sliderize(container_favorite);

  var container_watched = $('[data-slider-watched]');
  _sliderize(container_watched);

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

