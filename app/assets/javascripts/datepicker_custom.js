$(function() {
  $.datepicker.regional['br'] = {
    closeText: 'Fechar',
    currentText: 'Hoje',
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho', 'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb'],
    dayNamesMin: ['Do','Se','Te','Qu','Qu','Se','Sá'],
    dateFormat: 'dd/mm/yy'
  };

  $.datepicker.setDefaults($.datepicker.regional['br']);
});
