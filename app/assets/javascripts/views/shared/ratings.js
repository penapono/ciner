function Ratings() {
  'use strict';

  // globals

  var self = this;

  // public

  self.bindRatings = function(aContainer) {
    _bindRatings(aContainer);
  };

  function _bindRatings(aContainer) {
    var dataRatings = aContainer.find('[data-star-rating]');

    $(dataRatings).on('click', '[data-star]', function() {
      var self = $(this),
          parent = self.closest('[data-star-rating]'),
          filmable_type = parent.data("filmable-type"),
          filmable_id = parent.data("filmable-id"),
          user_id = parent.data("user-id"),
          rating = self.data("rating"),
          data = {
            user_filmable_rating: {
              filmable_type: filmable_type,
              filmable_id: filmable_id,
              user_id: user_id,
              rating: rating
            }
          }

      _rate(url, aData);
      alert("Clicou na estrela " + rating + "!");
    });

    $(dataRatings).on('mouseover', '[data-star]', function() {
      var self = $(this),
          parent = self.closest('[data-star-rating]'),
          stars = parent.find('[data-star]'),
          rating = self.data("rating");

      stars.removeClass('fa-star');
      stars.addClass('fa-star-o');
      stars.css('color', 'black');

      for(var i = 0; i < rating; i++) {
        var star = $(stars[i]);
        star.removeClass('fa-star-o');
        star.addClass('fa-star');
        star.css('color', 'rgb(225, 190, 59)');
      }
    });
  }

  function _rate(aUrl, aData) {
    $.ajax({
      type: 'POST',
      dataType: 'JSON',
      url: aUrl,
      data: aData,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data) {
        toastr.info("Obrigado por classificar o filme!");
      }
    });
  }
};

$(function() {
  'use strict';

  (new Ratings()).bindRatings($("#filmable-rating"));
});
