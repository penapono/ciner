# frozen_string_literal: true

class SearchesController < ApplicationController
  SEARCH_LIMIT = 4

  expose(:movies) { Movie.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:series) { Serie.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:professionals) { Professional.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:curriculums) { Curriculum.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:broadcasts) { Broadcast.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:events) { Event.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:critics) { Critic.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:questions) { Question.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:ciner_productions) { CinerProduction.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
  expose(:users) { User.search(nil, params.fetch(:search, '')).limit(SEARCH_LIMIT) }
end
