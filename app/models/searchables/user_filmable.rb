# frozen_string_literal: true

module Searchables
  module UserFilmable
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      movies.title LIKE :search OR
      series.title LIKE :search
    '

    SEARCH_ASSOCIATIONS = %i[
      movie serie
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      nil
    end

    def search_title
      nil
    end

    def search_description
      nil
    end
  end
end
