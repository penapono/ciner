# frozen_string_literal: true
module Reactionable
  extend ActiveSupport::Concern

  included do
    def likes_count
      get_upvotes.size
    end

    def dislikes_count
      get_downvotes.size
    end

    def like_icon_class(user)
      return 'fa fa-thumbs-o-up' unless user
      user.voted_up_on? self ? 'fa fa-thumbs-up' : 'fa fa-thumbs-o-up'
    end

    def dislike_icon_class(user)
      return 'fa fa-thumbs-o-down' unless user
      user.voted_down_on? self ? 'fa fa-thumbs-down' : 'fa fa-thumbs-o-down'
    end
  end
end
