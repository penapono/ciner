# frozen_string_literal: true

class SearchesController < ApplicationController
  expose(:movies) { Movie.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:series) { Serie.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:professionals) { Professional.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:curriculums) { Curriculum.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:broadcasts) { Broadcast.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:events) { Event.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:critics) { Critic.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:questions) { Question.search(nil, params.fetch(:search, '')).limit(10) }
  expose(:ciner_videos) { CinerVideo.search(nil, params.fetch(:search, '')).limit(10) }
end
