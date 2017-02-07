//= require views/shared/form

$(function() {
  'use strict';

  $('[data-questionable]').on("change", "[data-questionable-select] select", function(event) {
    var self = $(this),
        value = self.val();

    alert(value);

    _changeSelect(value);
  });

  $('[data-questionable]').on("change", "[data-questionable-type] select", function(event) {
    var self = $(this),
        value = self.val();

    $('[data-questionable-type] select').value = value;
    event.stopPropagation();
  });

  function _changeSelect(aValue) {
    _manageClass(aValue, "hidden");
  }

  function _manageClass(aSelectorToRemoveClass, aClass) {
    var aDataToAddClass       = "[data-questionable-type]",
        aDataToRemoveClass    = "[data-questionable-type=" + aSelectorToRemoveClass + "]",
        aSelectToAddClass     = $(aDataToAddClass),
        aSelectToRemoveClass  = $(aDataToRemoveClass);

    // Hide all selects
    aSelectToAddClass.addClass(aClass);

    // Show only the desired select
    aSelectToRemoveClass.removeClass(aClass);
  }
});
