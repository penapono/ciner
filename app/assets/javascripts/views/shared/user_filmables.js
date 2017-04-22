function UserFilmables() {
  'use strict';

  // globals

  var self = this;

  // public

  self.bindUserFilmables = function(aContainer) {
    _bindUserFilmables(aContainer);
  };

  function _bindUserFilmables(aContainer) {
    var dataUserFilmables = aContainer.find('[data-user-action]');

    $(dataUserFilmables).on('click', '.button', function() {
      var self = $(this),
          parent = self.closest('[data-user-action]'),
          url = parent.data("url"),
          user_id = parent.data("user-id"),
          filmable_id = parent.data("filmable-id"),
          filmable_type = parent.data("filmable-type"),
          user_action = self.data("action"),
          data = {
            user_id: user_id,
            filmable_id: filmable_id,
            filmable_type: filmable_type,
            user_action: user_action
          };

      _action(parent, url, data, self);
    });
  }

  function _action(aParent, aUrl, aData, aButton) {
    console.log(aData);
    $.ajax({
      type: 'PUT',
      dataType: 'JSON',
      data: aData,
      url: aUrl,
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
      success: function(data) {
        _updateUserFilmables(aParent, data, aButton);
        _updateCounters(aParent, data);
      }
    });
  }

  function _updateUserFilmables(aParent, aData, aButton) {
    var classToAdd = aData.result_class;

    aButton.find('a').removeClass('active');
    aButton.find('a').addClass(classToAdd);
  }

  function _updateCounters(aParent, aData) {
    var watched_str = aData.watched_str,
        want_to_see_str = aData.want_to_see_str,
        collection_str = aData.collection_str,
        favorite_str = aData.favorite_str,
        like_str = aData.like_str;

    aParent.find("[data-action='watched'] [data-count]").html(watched_str);
    aParent.find("[data-action='want_to_see'] [data-count]").html(want_to_see_str);
    aParent.find("[data-action='collection'] [data-count]").html(collection_str);
    aParent.find("[data-action='favorite'] [data-count]").html(favorite_str);
    aParent.find("[data-action='like'] [data-count]").html(like_str);
  }
};
