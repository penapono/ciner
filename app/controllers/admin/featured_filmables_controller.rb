# frozen_string_literal: true

module Admin
  class FeaturedFilmablesController < AdminController
    include Admin::FeaturedFilmablesBreadcrumb

    # exposes
    expose(:filmables) { Movie.featured.first(10) }

    def index
      return if filmables.blank?
    end
  end
end
