# frozen_string_literal: true
module Searchables
  module Critic
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      critics.content LIKE :search OR
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
      url_helper.admin_critics_path(critic: id)
    end

    def search_title
      content
    end

    def search_description
      content
    end
  end
end
