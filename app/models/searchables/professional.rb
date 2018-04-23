# frozen_string_literal: true

module Searchables
  module Professional
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      professionals.name LIKE :search OR
      professionals.nickname LIKE :search
    '

    SEARCH_ASSOCIATIONS = %i[
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_professionals_path(professional: id)
    end

    def search_title
      name
    end

    def search_description
      biography
    end
  end
end
