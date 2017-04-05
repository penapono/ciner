var scaling = 1.00;
//count
var currentSliderCount = 0;
var videoCount = $(".slider-container").children().length;
var showCount = 4;
var sliderCount = videoCount / showCount;
var controlsWidth = 40;
var scollWidth = 0;


$(document).ready(function(){
    init();

});
$( window ).resize(function() {
    init();
});
function init(){
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
     if(windowWidth >= 0 && windowWidth <= 414){
       showCount = 2;
   }else if(windowWidth >= 414 &&  windowWidth <= 768){
       showCount = 3;
   }else{
       showCount = 4;
   }
    var videoWidth = ((windowWidth - controlsWidth * 2) / showCount );
    var videoHeight = Math.round(videoWidth / (16/9));

    var videoWidthDiff = (videoWidth * scaling) - videoWidth;
    var videoHeightDiff = (videoHeight * scaling) - videoHeight;

    //set sizes
    // sliderFrame.width(windowWidth);
    sliderFrame.width("100%");
    sliderFrame.height(videoHeight * scaling);


    sliderFrame.css("top", (videoHeightDiff / 2));

    sliderContainer.height(videoHeight * scaling);
    sliderContainer.width((videoWidth * videoCount) + videoWidthDiff);
    sliderContainer.css("top", (videoHeightDiff / 2));
    sliderContainer.css("margin-left", (controlsWidth));

    slide.height(videoHeight);
    // slide.width(videoWidth);
    slide.width("130px");

    //hover effect
    $(".slide").mouseover(function() {
        // $(this).css("width", videoWidth * scaling);
        // $(this).css("height", videoHeight * scaling);
        $(this).css("width", "140px");
        $(this).css("top", -(videoHeightDiff / 2));
        if($(".slide").index($(this)) == 0 || ($(".slide").index($(this))) % 4 == 0){
          // do nothing
        }
        else if(($(".slide").index($(this)) + 1) % 4 == 0 && $(".slide").index($(this)) != 0){
            $(this).parent().css("margin-left", -(videoWidthDiff - controlsWidth));
        }
        else{
            $(this).parent().css("margin-left", - (videoWidthDiff / 2));
        }
    }).mouseout(function() {
        $(this).css("width", "130px");
        // $(this).css("height", videoHeight * 1);
        $(this).css("top", 0);
        $(this).parent().css("margin-left", controlsWidth);
    });

    // controls
    controls(frameWidth, scollWidth);
}
function controls(frameWidth, scollWidth){
    var prev = $(".prev");
    var next = $(".next");

    next.on("click", function(){
        console.log(currentSliderCount);
        console.log(sliderCount);
        scollWidth = scollWidth + frameWidth;
        var self = $(this),
            sliderFrame = self.closest('.slider-frame'),
            sliderContainer = sliderFrame.find('.slider-container');

        sliderContainer.animate({
            left: - scollWidth
        }, 300, function(){
            if(currentSliderCount >= sliderCount-1){
                $(".slider-container").css("left", 0);
                currentSliderCount = 0;
                scollWidth = 0;
            }else{
                currentSliderCount++;
            }
        });
    });
    prev.on("click", function(){
        scollWidth = scollWidth - frameWidth;
        var self = $(this),
            sliderFrame = self.closest('.slider-frame'),
            sliderContainer = sliderFrame.find('.slider-container');

        sliderContainer.animate({
            left: + scollWidth
        }, 300, function(){
            currentSliderCount--;
        });
    });
};
