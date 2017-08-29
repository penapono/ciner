//= require components/ciner_slider
//= require components/ciner_tipsy

$(document).ready(function() {
  var containers = $('[data-slider-playing]');

  for(var i = 0; i < containers.length; i++) {
    _sliderize($(containers[i]));
  }
});

function _sliderize(aContainer) {
  var cinerSlider = new CinerSlider();
  cinerSlider.sliderize(aContainer);
}
