# frozen_string_literal: true
class BroadcastBroadcastable < ActiveRecord::Base
  # Associations
  belongs_to :broadcastable, polymorphic: true

  belongs_to :broadcast

  # Validations
  validates :broadcast,
            :broadcastable_id,
            :broadcastable_type,
            presence: true
end
