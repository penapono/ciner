$(function(){
  $(document).on('click', '[data-collapsed-area] [data-collapse-control]', function(){
    var self = $(this),
        parent = self.closest('[data-collapsed-area]'),
        content = parent.find('[data-collapse-content]');

    _updateCollapsed(self, content);
  });

  function _updateCollapsed(aControl, aContent) {
    if (aContent.hasClass('collapse')) {
      _show(aControl, aContent);
    }
    else {
      _collapse(aControl, aContent);
    }
  }

  function _show(aControl, aContent) {
    _updateContent(aContent, 'collapse', '')
    _updateControlText(aControl, 'Ver menos')
  }

  function _collapse(aControl, aContent) {
    _updateContent(aContent, '', 'collapse')
    _updateControlText(aControl, 'ver mais')
  }

  function _updateContent(aContent, aRemoveClass, aAddClass) {
    aContent.removeClass(aRemoveClass);
    aContent.addClass(aAddClass);
  }

  function _updateControlText(aControl, aText) {
    aControl.html(aText);
  }
});
