$(function() {
  'use strict';

  $("[data-plans]").on("click", "[data-choose-plan] .btn", function(event) {
    var self = $(this),
        parentElement = self.closest('.assine'),
        choosenPlan = parentElement.data("plan"),
        dataForm = $('[data-form]'),
        dataPlans = $('[data-plans]'),
        documentToScroll = $('html,body');

    dataForm.removeClass('hidden');

    $('#user_name').focus();

    $('#user_role option').
      filter(function() { return $.trim( $(this).text() ) == choosenPlan; }).
      attr('selected',true);
  });
});
