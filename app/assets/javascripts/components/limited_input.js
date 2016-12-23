$(function() {
  'use strict';

  $(document).ready(function() {
    var input = $('[data-limited] textarea');

    _calculateRemaining(input);
  });

  $('[data-limited]').on('input', 'textarea', function() {
    var input = $(this);

    _calculateRemaining(input);
  });

  // privates

  function _calculateRemaining(aInput) {
    var parent = aInput.closest('[data-limited]'),
        typed = aInput.val().length,
        limit = parent.data('limit'),
        charCounter = parent.find('.char-counter'),
        remaining = limit - typed;

    charCounter.text(remaining +' caracteres restantes.');
  }
});
