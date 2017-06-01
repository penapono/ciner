# frozen_string_literal: true

module Searchables
  module Serie
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      series.original_title LIKE :search OR
      series.title LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_series_index_path(serie: id)
    end

    def search_title
      title
    end

    def search_description
      synopsis
    end
  end
end
