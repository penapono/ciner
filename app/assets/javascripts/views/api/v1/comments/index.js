//= require views/shared/reactions

$(function() {
  'use strict';

  var gContainer = $('[data-comments-section]');

  _loadComments(gContainer);

  function _loadComments(aContainer) {
    var path = aContainer.data('path'),
        commentableType = aContainer.data('commentableType'),
        commentableId = aContainer.data('commentableId');

    var params = {
      commentableType: commentableType,
      commentableId: commentableId
    };

    $.ajax({
      url : path,
      type: "GET",
      dataType: "html",
      data: params,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(data) {
        _reloadContent(aContainer, data);
      }
    });
  }

  function _reloadContent(aContainer, aData) {
    aContainer.empty().append(aData);

    _formAction();
    _deleteComment();
    (new Reactions()).bindReactions(gContainer);
  }

  function _formAction() {
    $("[data-submit]").click(function(e) {
      var self = $(this),
          form = $(this).closest('form');

      $.ajax({
        type: "POST",
        url : '/api/v1/comments',
        data : form.serialize(),
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: function(data) {
          _loadComments(gContainer);
        }
      });
    });
  }

  function _deleteComment() {
    $("[data-remove]").click(function(e) {
      var self = $(this),
          id = $(this).data('comment-id');

      $.ajax({
        type: "DELETE",
        url : '/api/v1/comments/' + id,
        success: function(data) {
          _loadComments(gContainer);
        }
      });
    });
  }
});
