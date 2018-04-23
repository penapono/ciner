# frozen_string_literal: true

class Notification < ActiveRecord::Base
  acts_as_paranoid

  # Validations
  validates :receiver_id,
            presence: true

  # Enums
  enum status: { pending: 0, read: 1 }
  enum answer: { no_answer: 0, waiting: 1, approved: 2, declined: 3 }
  enum notification_type: {
    friend_request: 0,
    accept_friend_request: 1,
    decline_friend_request: 2,
    delate_ok: 3,
    trophy: 4,
    contact: 5,
    accept_contact: 6,
    decline_contact: 7,
    ciner_production_pending: 8,
    ciner_production_approved: 9,
    ciner_production_reproved: 10,
    ciner_production_waiting: 11,
    recommend_filmable: 12
  }

  def self.for_user(user)
    Notification.where(receiver_id: user.id, answer: [0, 1]).order(status: :asc)
  end

  def sender
    User.find(sender_id)
  rescue StandardError
    :system
  end

  def from_ciner?
    sender == :system
  end

  def receiver
    User.find(receiver_id)
  end

  def sender_avatar
    return "ciner.png" if sender == :system
    sender.avatar
  end

  def created_at_str
    (I18n.l created_at, format: :short)
  end
end
