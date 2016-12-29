# frozen_string_literal: true
module Searchables
  module SetFunction
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      set_functions.name LIKE :search OR
      set_functions.description LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_set_functions_path(set_function: id)
    end

    def search_title
      name
    end

    def search_description
      description
    end
  end
end
