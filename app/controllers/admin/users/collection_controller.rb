# frozen_string_literal: true

module Admin
  module Users
    class CollectionController < ApplicationController
      # exposes
      expose(:user)
      expose(:filmables) { user.user_collection }

      def index
        return if filmables.blank?
        self.filmables = paginated_filmables
      end

      private

      def paginated_filmables
        filtered_filmable
      end

      def filtered_filmable
        filmables.filter_by(filmables, params.fetch(:filter, ''))
      end
    end
  end
end
