# frozen_string_literal: true

class UserTrophy < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper

  acts_as_paranoid

  # Validations
  validates :user,
            :trophy,
            presence: true

  # Associations
  belongs_to :user
  belongs_to :trophy

  delegate :name, to: :trophy, allow_nil: true, prefix: true

  after_create :notify_user

  def notify_user
    link =
      link_to(
        trophy_name,
        Rails.application.routes.url_helpers.platform_user_trophies_path(
          user
        )
      )

    message = "Você conquistou o trofeu '#{link}'!"
    Notification
      .find_or_create_by(receiver_id: user.id,
                         notification_type: :trophy,
                         answer: :no_answer,
                         message: message)
  end
end
