# frozen_string_literal: true

module Searchables
  module Country
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      countries.name LIKE :search OR
      countries.acronym LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_countries_path(country: id)
    end

    def search_title
      acronym
    end

    def search_description
      name
    end
  end
end
