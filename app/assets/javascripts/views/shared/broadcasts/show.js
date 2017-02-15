//= require views/shared/reactions
//= require views/api/v1/comments/index

$(function() {
  'use strict';

  (new Reactions()).bindReactions($("#broadcast-reaction"));
});
