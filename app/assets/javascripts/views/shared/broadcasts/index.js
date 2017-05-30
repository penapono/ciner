//= require views/shared/index
//= require components/ciner_tipsy
//= require views/shared/reactions

$(function() {
  'use strict';

  var broadcastReactions = $(".broadcast-reaction");

  var arrayLength = broadcastReactions.length;
  for (var i = 0; i < arrayLength; i++) {
    (new Reactions()).bindReactions($(broadcastReactions[i]));
  }
});
