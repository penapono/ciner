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

  function _bindLimitedInput() {
    var textArea = $('[data-limited] textarea'),
        input = $('[data-limited] input');

    var arrayLength = textArea.length;
    for (var i = 0; i < arrayLength; i++) {
      _calculateRemaining($(textArea[i]));
    }

    arrayLength = input.length;
    for (var i = 0; i < arrayLength; i++) {
      _calculateRemaining($(input[i]));
    }

    $('[data-limited]').on('input', 'textarea', function() {
      var input = $(this);
      _calculateRemaining(input);
    });

    $('[data-limited]').on('input', 'input', function() {
      var input = $(this);
      _calculateRemaining(input);
    });
  }

  function _calculateRemaining(aInput) {
    var parent = aInput.closest('[data-limited]'),
        typed = aInput.val().length,
        limit = parent.data('limit'),
        charCounter = parent.find('.char-counter'),
        remaining = limit - typed;

    charCounter.text(remaining +' caracteres restantes.');
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
    _bindLimitedInput();
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
