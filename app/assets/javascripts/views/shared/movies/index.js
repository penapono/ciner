//= require components/ciner_slider
//= require components/ciner_tipsy

$(document).ready(function() {
  var container = $('[data-slider-playing]');
  _sliderize(container);

  container = $('[data-slider-featured]');
  _sliderize(container);

  container = $('[data-slider-playing-soon]');
  _sliderize(container);

  container = $('[data-slider-available-netflix]');
  _sliderize(container);

  container = $('[data-slider-available-amazon]');
  _sliderize(container);
});

// $(window).resize(function() {
//   var container = $('[data-slider-playing]');
//   _sliderize(container);
// });

function _sliderize(aContainer) {
  var cinerSlider = new CinerSlider();
  cinerSlider.sliderize(aContainer);
}
