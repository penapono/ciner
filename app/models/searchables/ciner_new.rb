# frozen_string_literal: true
module Searchables
  module CinerNew
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      ciner_news.name LIKE :search OR
      ciner_news.content LIKE :search OR
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
      url_helper.admin_ciner_news_index_path(ciner_new: id)
    end

    def search_title
      name
    end

    def search_description
      content
    end
  end
end
