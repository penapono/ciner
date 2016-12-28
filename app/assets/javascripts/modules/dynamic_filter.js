$(function(){
  'use strict';

  $(document).on('change', '[data-dynamic-filter] [data-dynamic-input]', function(){
    $(this).closest('form').submit();
  });

});
