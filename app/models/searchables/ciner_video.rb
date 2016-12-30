# frozen_string_literal: true
module Searchables
  module CinerVideo
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      ciner_videos.original_title LIKE :search OR
      ciner_videos.title LIKE :search OR
      ciner_videos.synopsis LIKE :search OR
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
      url_helper.admin_ciner_videos_path(ciner_video: id)
    end

    def search_title
      title
    end

    def search_description
      synopsis
    end
  end
end
