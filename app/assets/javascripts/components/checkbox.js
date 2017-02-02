$(function(){
  $(document).on('click', '[data-checkboxes] input[type="checkbox"]', function(){
    var checkbox  = $(this);

    _updateCheckbox(checkbox);
  });

  // private

  function _updateCheckbox(aCheckbox){
    var status    = aCheckbox.prop('checked'),
        container = aCheckbox.closest('[data-check-box]');

    _updateCheckboxClass(container, status);
  }

  function _updateCheckboxClass(aContainer, aStatus){
    if (aStatus) {
      aContainer.addClass('checked');
    }else{
      aContainer.removeClass('checked');
    }
  }

});
