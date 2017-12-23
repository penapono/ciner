//= require views/shared/form

$(function(){
  'use strict';

  var gCocoonContainer  = $('[data-cocoon-container]');

  updateNestedLinks();

  $('[data-images]').bind('cocoon:after-insert', updateNestedLinks);
  $('[data-images]').bind('cocoon:after-remove', updateNestedLinks);

  gCocoonContainer.on('click', '[data-file-select]', function(){
    var container     = $(this).closest('[data-nested-fields]'),
        fileSelector  = container.find('[data-file], [data-box-file]');

    fileSelector.click();
  });

  gCocoonContainer.on('change', '[data-file]', function(){
    var container = $(this).closest('[data-nested-fields]'),
        fileName  = container.find('[data-file-name]'),
        file      = $(this).prop('files');

    _updateFilename(file, fileName);
  });

  gCocoonContainer.on('change', '[data-box-file]', function(){
    var container   = $(this).closest('[data-nested-fields]'),
        fileName    = container.find('[data-file-name]'),
        file        = $(this).prop('files'),
        deleteLink  = container.find('[data-remove]');

    _updateFilename(file, fileName, deleteLink);
  });

  // private

  function _updateFilename(aFile, aFileContainer, aShowDelete){
    if (aFile.length > 0) {
      aFileContainer.html(aFile[0].name);
      _showDelete(aShowDelete);
    }else {
      aFileContainer.html('Nenhum arquivo selecionado');
    }
  }

  function _showDelete(aDeleteContainer){
    var deleteFlag = (typeof aDeleteContainer !== 'undefined');

    if (deleteFlag) {
      aDeleteContainer.show();
    }
  }

  function updateNestedLinks() {
    var container = $('[data-images]');

    if (container.find('.nested-fields:visible').length >= 4) {
      container.find('.links').hide();
    } else {
      container.find('.links').show();
    }
  }


  $('form').on('cocoon:after-insert', function(e, insertedItem) {
  $('.datepicker').mask('99/99/9999');
  $('.money').mask('000.000.000.000.000,00', { reverse: true });
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
});
});

