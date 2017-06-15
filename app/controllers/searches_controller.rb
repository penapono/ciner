# frozen_string_literal: true

class SearchesController < ApplicationController
  expose(:movies) { Movie.search(nil, params.fetch(:search, '')).limit(15) }
  expose(:series) { Serie.search(nil, params.fetch(:search, '')).limit(15) }
  expose(:broadcasts) { Broadcast.search(nil, params.fetch(:search, '')).limit(15) }
  expose(:events) { Event.search(nil, params.fetch(:search, '')).limit(15) }
  expose(:critics) { Critic.search(nil, params.fetch(:search, '')).limit(15) }
  expose(:questions) { Question.search(nil, params.fetch(:search, '')).limit(15) }
  expose(:ciner_videos) { CinerVideo.search(nil, params.fetch(:search, '')).limit(15) }
end
