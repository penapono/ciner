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
        cities.append(new Option("Município", ""));
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
