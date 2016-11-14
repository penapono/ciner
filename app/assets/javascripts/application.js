//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require_tree .

var timer = 0;
var t0 = 0;
var t1 = 0;

$('#terms-link').click(function (event) {
  t0 = Date.now();
  showTerms();
  event.preventDefault(); // Prevent link from following its href
});

function showTerms(){
  $('.overlay-bg').show();
  $('.terms-container').show();
}

$('#close-terms').click(function (event) {
  $('.overlay-bg').hide();
  $('.terms-container').hide();
  t1 = Date.now();
  timer = timer + (t1-t0);
  event.preventDefault();
});