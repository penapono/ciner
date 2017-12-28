function Ratings() {
  'use strict';

  // globals

  var self = this;

  // public

  self.bindRatings = function(aContainer) {
    _bindRatings(aContainer);
  };

  function _bindRatings(aContainer) {
    var gDataRatings = aContainer.find('[data-star-rating]');
    var gCurrentRating = 0;

    $(gDataRatings).on('click', '[data-star]', function() {
      var self = $(this),
          parent = self.closest('[data-star-rating]'),
          url = parent.data('url'),
          filmable_type = parent.data("user-filmable-rating-filmable-type"),
          filmable_id = parent.data("user-filmable-rating-filmable-id"),
          user_id = parent.data("user-filmable-rating-user-id"),
          rating = self.data("rating"),
          data = {
            user_filmable_rating: {
              filmable_type: filmable_type,
              filmable_id: filmable_id,
              user_id: user_id,
              rating: rating
            }
          }

      _rate(url, data, parent);
    });

    $(gDataRatings).on('mouseover', '[data-star]', function() {
      var self = $(this),
          parent = self.closest('[data-star-rating]'),
          stars = parent.find('[data-star]'),
          rating = self.data("rating");

      _paintStars(stars, rating);
    });

    $('[data-filmable-rating]').on('mouseleave', '[data-star-rating]', function() {
      var self = $(this),
          rating = self.attr("data-user-rating"),
          stars = self.find('[data-star]');

      if (gCurrentRating != rating) {
        gCurrentRating = rating;
      }

      _paintStars(stars, gCurrentRating);
    });
  }

  function _rate(aUrl, aData, aParent) {
    $.ajax({
      type: 'POST',
      dataType: 'JSON',
      url: aUrl,
      data: aData,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data) {
        toastr.info("Obrigado por classificar!");
        $('[data-users-rating]').html(data.current_rating);
        $('[data-star-rating]').attr('data-user-rating', data.user_rating);
        _paintStars(aParent.find('[data-star]'), data.user_rating);
      }
    });
  }

  function _paintStars(aStarArray, aRating) {
    aStarArray.removeClass('fa-star');
    aStarArray.addClass('fa-star-o');
    aStarArray.css('color', 'black');

    for(var i = 0; i < aRating; i++) {
      var star = $(aStarArray[i]);
      star.removeClass('fa-star-o');
      star.addClass('fa-star');
      star.css('color', 'rgb(225, 190, 59)');
    }
  }
};

$(function() {
  'use strict';

  (new Ratings()).bindRatings($("#filmable-rating"));
});
