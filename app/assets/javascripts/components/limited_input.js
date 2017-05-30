$(function() {
  'use strict';

  $(document).ready(function() {
    var textArea = $('[data-limited] textarea'),
        input = $('[data-limited] input');

    var arrayLength = textArea.length;
    for (var i = 0; i < arrayLength; i++) {
      _calculateRemaining($(textArea[i]));
    }

    arrayLength = input.length;
    for (var i = 0; i < arrayLength; i++) {
      _calculateRemaining($(input[i]));
    }

    $('[data-limited]').on('input', 'textarea', function() {
      var input = $(this);

      _calculateRemaining(input);
    });

    $('[data-limited]').on('input', 'input', function() {
      var input = $(this);

      _calculateRemaining(input);
    });
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
