//= require select2-full
//= require select2_locale_pt-BR

$(function() {
  'use strict';

  $('select').select2({
    theme: "bootstrap",
    minimumResultsForSearch: 30
  });


  $('[data-remote-select]').select2(_remoteDataConfig());

  function _remoteDataConfig() {
    return {
      language: 'pt-BR',
      allowClear: false,
      minimumInputLength: 2,
      closeOnSelect: true,
      ajax: _defaultAjaxParams()
    }
  }

  function _defaultAjaxParams() {
    return {
      dataType: 'json',
      delay: 250,
      data: function (search) {
        return {
          search: search
        };
      },

      processResults: function (data) {
        return {
          results: data
        };
      }
    };
  }
});
