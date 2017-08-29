# frozen_string_literal: true

class FeaturedFilmablesController < ApplicationController
  include FeaturedFilmablesBreadcrumb

  # exposes
  expose(:filmables) { Movie.featured.first(10) }

  def index
    return if filmables.blank?
  end
end
