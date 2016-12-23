$(function() {
  'use strict';

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
});
