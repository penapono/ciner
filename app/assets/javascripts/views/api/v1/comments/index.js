//= require views/shared/reactions

$(function() {
  'use strict';

  var gContainer = $('[data-comments-section]');

  _loadComments(gContainer);

  function _loadComments(aContainer) {
    var path = aContainer.data('path'),
        params = "";
        // params = aContainer.data('params');

    $.get(path, params)
      .done(function(data){
        _reloadContent(aContainer, data);
    });
  }

  function _reloadContent(aContainer, aData) {
    aContainer.empty().append(aData);

    _formAction();
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
});
