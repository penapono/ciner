# frozen_string_literal: true

module Platform
  module Users
    class FriendsController < ApplicationController
      # exposes
      expose(:user)
      expose(:friends) { user.friends }

      def index
        return if friends.blank?

        self.friends = paginated_friends
      end

      private

      def paginated_friends
        filtered_friends
      end

      def filtered_friends
        friends.filter_by(friends, params.fetch(:filter, ''))
      end
    end
  end
end
