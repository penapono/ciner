# frozen_string_literal: true

class CinerVideoUser < ActiveRecord::Base
  # Associations
  belongs_to :set_function
  belongs_to :user
  belongs_to :ciner_video

  # Validations
  validates :set_function_id,
            :user_id,
            :ciner_video_id,
            presence: true
end
