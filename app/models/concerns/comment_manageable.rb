# frozen_string_literal: true

module CommentManageable
  extend ActiveSupport::Concern

  included do
    def update_comments_count(size = 0)
      update_attributes(comments_count: comments.size + size)
    end

    def last_comment
      return unless comments.exists?
      comments.order(created_at: :desc).first
    end

    def last_updated_time(object)
      ((Time.now - object.created_at) / 1.hour).round
    end

    def comments_count_str
      return "+ 99999" if comments_count > 99_999
      comments_count
    end
  end
end
