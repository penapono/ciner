# frozen_string_literal: true
module Searchables
  module Studio
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      studios.name LIKE :search OR
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
      url_helper.admin_studios_path(studio: id)
    end

    def search_title
      name
    end

    def search_description
      name
    end
  end
end
