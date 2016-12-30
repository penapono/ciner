# frozen_string_literal: true
module Searchables
  module Critic
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      critics.name LIKE :search OR
      critics.content LIKE :search OR
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
      url_helper.admin_critics_path(critic: id)
    end

    def search_title
      name
    end

    def search_description
      content
    end
  end
end
