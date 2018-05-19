//= require views/shared/form

$(function() {
  'use strict';

  $('[data-filmable]').on("change", "[data-filmable-select] select", function(event) {
    var self = $(this),
        value = self.val();

    _changeSelect(value);
  });

  $('[data-filmable]').on("change", "[data-filmable-type] select", function(event) {
    var self = $(this),
        value = self.val();

    $('[data-filmable-type] select').val(value);
  });

  function _changeSelect(aValue) {
    _manageClass(aValue, "hidden");
  }

  function _manageClass(aSelectorToRemoveClass, aClass) {
    var aDataToAddClass       = "[data-filmable-type]",
        aDataToRemoveClass    = "[data-filmable-type=" + aSelectorToRemoveClass + "]",
        aSelectToAddClass     = $(aDataToAddClass),
        aSelectToRemoveClass  = $(aDataToRemoveClass);

    // Hide all selects
    aSelectToAddClass.addClass(aClass);

    // Show only the desired select
    aSelectToRemoveClass.removeClass(aClass);
  }

  $('[data-remote-select]').select2(_remoteDataConfig());

    function _remoteDataConfig() {
      return {
        language: 'pt-BR',
        allowClear: false,
        minimumInputLength: 3,
        closeOnSelect: true,
        ajax: _defaultAjaxParams()
      }
    }

    function _defaultAjaxParams() {
      return {
        dataType: 'json',
        delay: 150,
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
