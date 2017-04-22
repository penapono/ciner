//= require views/shared/user_filmables

$(function() {
  'use strict';

  (new UserFilmables()).bindUserFilmables($("#user-actions"));
});
