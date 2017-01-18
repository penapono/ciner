//= require views/shared/form

$(function() {
  'use strict';

  $('[data-filmable]').on("change", "[data-filmable-select] select", function(event) {
    var self = $(this),
        value = self.val();

    _changeSelect(value);
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
});
