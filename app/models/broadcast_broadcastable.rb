# frozen_string_literal: true

class BroadcastBroadcastable < ActiveRecord::Base
  acts_as_paranoid

  # Associations
  belongs_to :broadcastable, polymorphic: true

  belongs_to :broadcast

  # Validations
  validates :broadcastable_id,
            :broadcastable_type,
            presence: true
end
