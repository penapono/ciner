//= require components/datepicker
//= require components/timepicker
//= require components/ciner_select2
//= require components/cep_finder
//= require components/limited_input
//= require components/checkbox
//= require components/cpf_validator
//= require views/shared/users/terms
//= require views/shared/users/plan_chooser

$(function() {
  'use strict';

  $('.datepicker').mask('99/99/9999');
  $('.money').mask('000.000.000.000.000,00', {reverse: true});
  $('.year').mask('0000');
  $('.height').mask('0,00', { reverse: true });
  $('.mannequin').mask('00');
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
});


  $('form').on("change", "#user_state_id", function(event) {
    var self = $(this),
        uf  = self.val();

    var state_attrs = {
      acronym: uf
    };

    $.ajax({
      url: "/api/v1/cities",
      type: "GET",
      data: state_attrs,
      success: function(d) {
        var cities = $("#user_city_id");

        cities.html('');
        for(var i = 0; i < d.length; i++) {
          cities.append(new Option(d[i].name, d[i].id));
        }
      },
      error: function(data) {
        console.log("Não achou as cidades!!");
      }
    });
  });
});
