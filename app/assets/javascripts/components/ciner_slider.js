var scaling = 1.00;
//count
var currentSliderCount = 0;
var videoCount = $(".slider-container").children().length;
var showCount = 1;
var sliderCount = videoCount / showCount;
var controlsWidth = 40;
var scollWidth = 0;
var slideWidth = 150;
var maxLeft = 0;
var minLeft = 0;
var marginTotal = 20;

$(document).ready(function() {
  $('.slider-container .slide:nth-last-child(-n+4)').prependTo('.slider-container');
  init();
});

$(window).resize(function() {
  init();
});

function init() {
  // elements
  var win = $(window);
  var sliderFrame = $(".slider-frame");
  var sliderContainer = $(".slider-container");
  var slide = $(".slide");

  //counts
  var scollWidth = 0;

  //sizes
  var windowWidth = win.width();
  var frameWidth = win.width() - 80;

  if (windowWidth >= 0 && windowWidth <= 414) {
    showCount = 2;
  } else if (windowWidth >= 414 && windowWidth <= 768) {
    showCount = 3;
  } else {
    showCount = 4;
  }

  sliderCount = videoCount / showCount;

  var videoWidth = ((windowWidth - controlsWidth * 2) / showCount);
  var videoHeight = Math.round(videoWidth / (16 / 9));

  var videoWidthDiff = (videoWidth * scaling) - videoWidth;
  var videoHeightDiff = (videoHeight * scaling) - videoHeight;

  sliderFrame.width("100%");
  sliderFrame.height("195px");
  sliderFrame.css("top", (videoHeightDiff / 2));

  frameWidth = showCount * slideWidth;

  sliderContainer.height(videoHeight * scaling);
  sliderContainer.width((videoWidth * videoCount) + videoWidthDiff);
  sliderContainer.css("top", (videoHeightDiff / 2));
  sliderContainer.css("margin-left", (controlsWidth));

  slide.height("195px");
  slide.width("130px");

  maxLeft = videoCount * slideWidth - (showCount * slideWidth) - (marginTotal * showCount)

  // controls
  controls(sliderFrame, frameWidth);
}

function controls(sliderFrame, frameWidth) {
  sliderFrame.on("click", ".next", function() {
    scollWidth = scollWidth + frameWidth;

    var self = $(this),
      sliderContainer = sliderFrame.find('.slider-container');

    if (scollWidth > maxLeft) {
      scollWidth = maxLeft;
    }

    sliderContainer.animate({
      left: -scollWidth
    }, 300, function() {
      if (currentSliderCount >= sliderCount) {
        sliderContainer.css("left", 0);
        currentSliderCount = 0;
        scollWidth = 0;
      } else {
        if (scollWidth >= maxLeft) {
          currentSliderCount = sliderCount;
        }
        currentSliderCount++;
      }
    });


  });

  sliderFrame.on("click", ".prev", function() {
    scollWidth = scollWidth - frameWidth;

    var self = $(this),
      sliderContainer = sliderFrame.find('.slider-container');

    if (scollWidth > 0) {
      scollWidth = minLeft;
    }

    sliderContainer.animate({
      left: scollWidth
    }, 300, function() {
      if (currentSliderCount < 2) {
        sliderContainer.css("left", 0);
        currentSliderCount = 0;
        scollWidth = 0;
      } else {
        currentSliderCount--;
        sliderContainer.css("left", scollWidth);
      }
    });
  });
};
