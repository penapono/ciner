# frozen_string_literal: true

module Platform
  class FeaturedFilmablesController < PlatformController
    include Platform::FeaturedFilmablesBreadcrumb

    # exposes
    expose(:filmables) { Movie.featured.first(10) }

    def index
      return if filmables.blank?
    end
  end
end
