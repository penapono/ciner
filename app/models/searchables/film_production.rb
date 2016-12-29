# frozen_string_literal: true
module Searchables
  module FilmProduction
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      film_production.original_title LIKE :search OR
      film_production.title LIKE :search OR
      film_production.synopsis LIKE :search OR
      cities.name LIKE :search OR
      states.name LIKE :search OR
      countries.name LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
      :city, :state, :country
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_film_productions_path(film_production: id)
    end

    def search_title
      title
    end

    def search_description
      synopsis
    end
  end
end
