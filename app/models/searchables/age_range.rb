# frozen_string_literal: true
module Searchables
  module AgeRange
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      age_ranges.name LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_age_ranges_path(age_range: id)
    end

    def search_title
      name
    end

    def search_description
      name
    end
  end
end
