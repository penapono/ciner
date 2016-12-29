# frozen_string_literal: true
module Searchables
  module FilmProductionCategory
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      film_production_categories.name LIKE :search OR
      film_production_categories.description LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_film_production_categories_path(film_production_category: id)
    end

    def search_title
      name
    end

    def search_description
      description
    end
  end
end
