$(function() {
  'use strict';

  $(document).ready(function () {
    if ($('[data-tipsy]').length) {
      $('[data-tipsy]').tipsy();
      //   fade: true,
      //   title: $(this).data("tipsy")
      // });
    }
  });
});
