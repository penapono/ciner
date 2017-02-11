# frozen_string_literal: true
module CommentManageable
  extend ActiveSupport::Concern

  included do
    def update_comments_count
      update_attributes(comments_count: comments.size)
    end

    def last_comment
      return unless comments.any?
      comments.order(created_at: :desc).first
    end
  end
end
