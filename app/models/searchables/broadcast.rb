# frozen_string_literal: true

module Searchables
  module Broadcast
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      broadcasts.title LIKE :search OR
      broadcasts.content LIKE :search OR
      users.name LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
      :user
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_broadcasts_path(broadcast: id)
    end

    def search_title
      title
    end

    def search_description
      content
    end
  end
end
