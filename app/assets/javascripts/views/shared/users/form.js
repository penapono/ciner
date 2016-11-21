//= require datepicker_custom

$(function() {
  'use strict';

  // Initialize datepickers
  $('input.datepicker').datepicker();

  // When add a field, datepicker is initialized
  $('form').on('cocoon:after-insert', function(e, insertedItem) {
    insertedItem.find('input.datepicker').datepicker();
  });

  $("[data-plans]").on("click", "[data-choose-plan] .btn", function(event) {
    var self = $(this),
        parentElement = self.closest('.assine'),
        choosenPlan = parentElement.data("plan"),
        dataForm = $('[data-form]'),
        dataPlans = $('[data-plans]'),
        documentToScroll = $('html,body');

    dataForm.removeClass('hidden');
    dataPlans.addClass('hidden');
    documentToScroll.animate({scrollTop: 0});

    $('#user_role option').
      filter(function() { return $.trim( $(this).text() ) == choosenPlan; }).
      attr('selected',true);
  });

  $('form').on('change', "[data-terms] input", function (event) {
    var self = $(this),
        checked = self.prop('checked'),
        dataTerms = self.closest('[data-terms]'),
        comboTerms = dataTerms.find('#user_terms_of_use');

    comboTerms.prop('checked', checked);
  });

  $('form').on('change', "[data-cep] input", function (event){
    var self = $(this),
        cepValue = self.val(),
        dataCEP = self.closest('[data-cep]'),
        path = dataCEP.data('path'),
        attrs = { cep: cepValue };

    var attrs = {
      cep: cepValue
    };

    $.ajax({
      url: path,
      type: "GET",
      data: attrs,
      success: function(data) {
        if(data.status == "ok") {
          $("#user_address").val(data.data.tipo_logradouro + " " + data.data.logradouro);
          $("#user_number").val("");
          $("#user_neighbourhood").val(data.data.bairro);

          var uf = data.data.uf;

          $('#user_state_id option').
            filter(function() { return $.trim( $(this).text() ) == uf; }).
            attr('selected',true);

          var city = data.data.cidade;

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

              $('#user_city_id option').
                filter(function() { return $.trim( $(this).text() ) == city; }).
                attr('selected',true);

              $("#search-cep-status").html("");

            },
            error: function(data) {
              console.log("Não achou as cidades!!");
            }
          });


        } else {
          console.log("Não achou o CEP!!");
        }
      },
      error: function(data) {
        console.log("erro ao buscar CEP!");
      }
    });
    event.stopPropagation();
  });

});

var timer = 0;
var t0 = 0;
var t1 = 0;


$('#terms-link').click(function (event) {
  t0 = Date.now();
  showTerms();
  event.preventDefault(); // Prevent link from following its href
});

function showTerms(){
  $('.overlay-bg').show();
  $('.terms-container').show();
}

$(document).ready(function(){
  var limit = 300;
  var typed = $("#user_biography").val().length;
  var rest = limit - typed;

  $("span.char-counter").text('Você ainda pode digitar '+rest+' caracteres.');
});

$(document).on("input", "#user_biography", function () {
  var limit = 300;
  var typed = $(this).val().length;
  var rest = limit - typed;

  $("span.char-counter").text('Você ainda pode digitar '+rest+' caracteres.');
});

$('#close-terms').click(function (event) {
  $('.overlay-bg').hide();
  $('.terms-container').hide();
  t1 = Date.now();
  timer = timer + (t1-t0);
  event.preventDefault();
});

$('.overlay-bg').click(function (event) {
  $('.overlay-bg').hide();
  $('.terms-container').hide();
  t1 = Date.now();
  timer = timer + (t1-t0);
  event.preventDefault();
});

var CPFoptions =  {
  onComplete: function() {
    if(!validateCPF()) {
      $('#user_cpf').val('');
      alert('CPF inválido!');
    }
  },
};

$(document).ready(function(){
  $('#user_birthday').mask('00/00/0000');
  $('#user_cpf').mask('000.000.000-00', CPFoptions);
  $('#user_phone').mask('(00) 0000-0000');
  $('#user_mobile').mask('(00) 0000-00000');
  $('#user_cep').mask('00000-000');
});

function validateCPF() {
  strCPF = $('#user_cpf').cleanVal();
  var Sum;
  var Rest;
  Sum = 0;
  if (strCPF == "00000000000") return false;

  for (i=1; i<=9; i++) Sum = Sum + parseInt(strCPF.substring(i-1, i)) * (11 - i);
  Rest = (Sum * 10) % 11;

    if ((Rest == 10) || (Rest == 11))  Rest = 0;
    if (Rest != parseInt(strCPF.substring(9, 10)) ) return false;

  Sum = 0;
    for (i = 1; i <= 10; i++) Sum = Sum + parseInt(strCPF.substring(i-1, i)) * (12 - i);
    Rest = (Sum * 10) % 11;

    if ((Rest == 10) || (Rest == 11))  Rest = 0;
    if (Rest != parseInt(strCPF.substring(10, 11) ) ) return false;
    return true;
}


