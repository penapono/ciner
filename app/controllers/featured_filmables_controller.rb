# frozen_string_literal: true

class FeaturedFilmablesController < ApplicationController
  include FeaturedFilmablesBreadcrumb

  # exposes
  expose(:filmables) { Movie.most_viewed.first(100) }

  PER_PAGE = 50

  def index
    return if filmables.blank?
  end

  private

  # Filtering

  def paginated_filmables
    filmables.page(params[:page]).per(PER_PAGE)
  end
end
