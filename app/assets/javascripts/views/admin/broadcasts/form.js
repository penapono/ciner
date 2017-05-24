//= require views/shared/form

$('form').on('cocoon:after-insert', function(e, insertedItem) {
  $('.datepicker').mask('99/99/9999');
  $('.money').mask('000.000.000.000.000,00', {reverse: true});
  $('select').select2({
    theme: "bootstrap",
    minimumResultsForSearch: 50
  });

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

  $('[data-filmable]').on("change", "[data-filmable-select] select", function(event) {
    var self = $(this),
        value = self.val();

    _changeSelect(value);1
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
});

