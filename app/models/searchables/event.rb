# frozen_string_literal: true
module Searchables
  module Event
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      events.title LIKE :search OR
      events.description LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_events_path(event: id)
    end

    def search_title
      title
    end

    def search_description
      description
    end
  end
end
