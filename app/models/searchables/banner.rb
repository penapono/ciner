# frozen_string_literal: true

module Searchables
  module Banner
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      banners.link LIKE :search OR
      banners.position LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_banners_path(banner: id)
    end

    def search_title
      name
    end

    def search_description
      description
    end
  end
end
