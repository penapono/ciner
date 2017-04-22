//= require components/ciner_slider

$(document).ready(function() {
  var container = $('[data-slider-playing]');
  _sliderize(container);
  // $('.slider-container .slide:nth-last-child(-n+4)').prependTo('.slider-container');
});

$(window).resize(function() {
  var container = $('[data-slider-playing]');
  _sliderize(container);
});

function _sliderize(aContainer) {
  var cinerSlider = new CinerSlider();
  cinerSlider.sliderize(aContainer);
}
