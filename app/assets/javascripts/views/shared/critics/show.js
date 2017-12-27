//= require views/shared/reactions
//= require star-rating.min

$(function() {
  'use strict';

  (new Reactions()).bindReactions($("#critic-reaction"));
});
