function CinerSlider() {
  'use strict';

  // globals

  var self = this;

  // public

  self.sliderize = function(aContainer) {
    _sliderize(aContainer);
  };

  // private

  function _sliderize(aContainer) {
    var currentSliderCount = 0;
    var videoCount = aContainer.find(".slider-container").children().length;
    var showCount = 1;
    var sliderCount = videoCount / showCount;
    var controlsWidth = 40;
    var scollWidth = 0;
    var slideWidth = 140;
    var maxLeft = 0;
    var minLeft = 0;
    var marginTotal = 10;

    // elements
    var win = $(window);
    var sliderFrame = aContainer.find(".slider-frame");
    var sliderContainer = aContainer.find(".slider-container");
    var slide = aContainer.find(".slide");

    //counts
    var scollWidth = 0;

    //sizes
    var windowWidth = win.width();
    var frameWidth = win.width() - 80;

    if (windowWidth >= 0 && windowWidth <= 414) {
      showCount = 2;
    } else if (windowWidth >= 414 && windowWidth <= 768) {
      showCount = 3;
    } else if (windowWidth >= 768 && windowWidth <= 900) {
      showCount = 4;
    } else {
      showCount = 5;
    }

    sliderCount = videoCount / showCount;

    var videoWidth = ((windowWidth - controlsWidth * 2) / showCount);
    var videoHeight = Math.round(videoWidth / (16 / 9));

    var videoWidthDiff = (videoWidth) - videoWidth;
    var videoHeightDiff = (videoHeight) - videoHeight;

    sliderFrame.width("100%");
    sliderFrame.height("195px");
    sliderFrame.css("top", (videoHeightDiff / 2));

    frameWidth = showCount * slideWidth;

    sliderContainer.height(videoHeight);
    sliderContainer.width((videoWidth * videoCount) + videoWidthDiff);
    sliderContainer.css("top", (videoHeightDiff / 2));
    sliderContainer.css("margin-left", -5);

    slide.height("195px");
    slide.width("130px");

    maxLeft = videoCount * slideWidth - (showCount * slideWidth) - (marginTotal * showCount)

    // controls
    // controls(sliderFrame, frameWidth);

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

      if (scollWidth < 0) {
        scollWidth = minLeft;
      }

      sliderContainer.animate({
        left: -scollWidth
      }, 300, function() {
        if (currentSliderCount < 2) {
          sliderContainer.css("left", 0);
          currentSliderCount = 0;
          scollWidth = 0;
        } else {
          currentSliderCount--;
          sliderContainer.css("left", -scollWidth);
        }
      });
    });
  }
}
