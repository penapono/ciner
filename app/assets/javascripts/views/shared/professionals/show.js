//= require components/ciner_slider
//= require components/ciner_tipsy

$(document).ready(function() {
  var containers = $('[data-slider-playing]');

  for(var i = 0; i < containers.length; i++) {
    _sliderize($(containers[i]));
  }
  // _sliderize(container);
  // $('.slider-container .slide:nth-last-child(-n+4)').prependTo('.slider-container');
});

// $(window).resize(function() {
//   var container = $('[data-slider-playing]');
//   _sliderize(container);
// });

function _sliderize(aContainer) {
  var cinerSlider = new CinerSlider();
  cinerSlider.sliderize(aContainer);
}
