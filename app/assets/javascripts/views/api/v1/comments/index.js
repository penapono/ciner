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

    $(gContainer).on("ajax:success", function(e, data, status, xhr) {
      alert("Hello!");
      if(data.status == "success") {
        _loadComments(gContainer);
      }
    });
  }

});
