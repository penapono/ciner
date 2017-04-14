$(function(){
  $(window).scroll(function () {
    var self = $(this);

    _controlNav(self);
  });

  function _controlNav(aWindow) {
    var nav = $('.nav-container'),
        containerFull = nav.find('[data-container-full]'),
        containerFixed = nav.find('[data-container-fixed]');

    if (aWindow.scrollTop() > 310) {
      _lockNav(nav, containerFixed, containerFull);
    } else {
      _releaseNav(nav, containerFull, containerFixed)
    }
  }

  function _lockNav(aNav, aContainerToShow, aContainerToHide) {
    if (!aNav.hasClass('f-nav')) {
      _manageNav(aNav, '', 'f-nav');
      _manageContainers(aContainerToShow, aContainerToHide);
    }
  }

  function _releaseNav(aNav, aContainerToShow, aContainerToHide) {
    if (aNav.hasClass('f-nav')) {
      _manageNav(aNav, 'f-nav', '');
      _manageContainers(aContainerToShow, aContainerToHide);
    }
  }

  function _manageContainers(aContainerToShow, aContainerToHide) {
    aContainerToShow.removeClass("collapse");
    aContainerToHide.addClass("collapse");
  }

  function _manageNav(aNav, aClassToRemove, aClassToAdd) {
    aNav.addClass(aClassToAdd);
    aNav.removeClass(aClassToRemove);
  }
});
