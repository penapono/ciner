$(function() {
  'use strict';

  $('[data-reactions]').on('click', '[data-vote]', function() {
    var self = $(this),
        url = self.data("url");

    _react(url);
  });

  function _react(aUrl) {
    $.ajax({
      type: 'PUT',
      dataType: 'JSON',
      url: aUrl,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data) {
        _updateReactions(data);
      }
    });
  }

  function _updateReactions(aData) {
    var dislikeCount = aData.dislike_count,
        likeCount = aData.like_count,
        likeIconClass = aData.like_icon,
        dislikeIconClass = aData.dislike_icon;

    _updateReaction('[data-like-counter]', '[data-like-icon]', likeCount, likeIconClass);
    _updateReaction('[data-dislike-counter]', '[data-dislike-icon]', dislikeCount, dislikeIconClass);
  }

  function _updateReaction(aCounterId, aIconId, aCount, aIconClass) {
    $(aCounterId).html(aCount);
    $(aIconId).removeClass();
    $(aIconId).addClass(aIconClass);
  }
});
