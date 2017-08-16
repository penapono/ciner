# frozen_string_literal: true

class BroadcastProfessional < ActiveRecord::Base
  belongs_to :broadcast
  belongs_to :professional


  # Validations
  validates :professional,
            presence: true
end
