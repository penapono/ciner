# frozen_string_literal: true

module Searchables
  module CinerProduction
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      ciner_productions.original_title LIKE :search OR
      ciner_productions.title LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_ciner_productions_path(ciner_production: id)
    end

    def search_title
      title
    end

    def search_description
      synopsis
    end
  end
end
