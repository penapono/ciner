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

  // Seleciona automaticamente o próximo

  var selection = insertedItem.closest('[data-selection]');

  if (selection.length > 0) {
    var nestedSelects = selection.find('[data-set-function-select] select');
    var total = nestedSelects.length;

    if (total > 1) {
      previous = $(nestedSelects[total-2]);
      next = $(nestedSelects[total-1]);
      previousVal = previous.val();

      next.val(previousVal).trigger('change.select2');
    }
  }

  var selectUser = insertedItem.find('[data-user-id-select]');

  // cria um próximo quando o anterior foi selecionado
  $(selectUser).on("select2:select", function(e) {
    var self = $(this),
        parent = self.closest('[data-selection]'),
        addButton = parent.find('.action-button.add');

    addButton.trigger('click');
  });
});
