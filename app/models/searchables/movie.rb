# frozen_string_literal: true

module Searchables
  module Movie
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      movies.original_title LIKE :search OR
      movies.title LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_movies_path(movie: id)
    end

    def search_title
      title
    end

    def search_description
      synopsis
    end
  end
end
