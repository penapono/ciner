# frozen_string_literal: true

class NotificationsController < ApplicationController
  include NotificationsBreadcrumb

  respond_to :html, :js

  # exposes
  expose(:notifications) { Notification.empty }

  def index
    self.notifications = paginated_notifications
  end

  def create
    type_based_create(params)
  end

  private

  def type_based_create(params)
    notification_type = params[:notification_type]
    notification_sender_id = params[:sender_id]
    notification_receiver_id = params[:receiver_id]

    if notification_type == 'friend_request'
      on_add_friend(notification_sender_id, notification_receiver_id)
    elsif notification_type == 'cancel_friend_request'
      on_accept_friend(notification_sender_id, notification_receiver_id)
      elsif notification_type == 'remove_friend'
        on_decline_friend(notification_sender_id, notification_receiver_id)
      end
    end
  end

  # Friendship
  def on_add_friend(sender_id, receiver_id)
    notification_sender = User.find(sender_id)

    notification = Notification.create(
      sender_id: sender_id,
      receiver_id: receiver_id,
      type: :friend_request,
      answer: :waiting,
      message: "#{link_to notification_sender, notification_sender.name} te enviou um pedido de amizade"
    )

    render json: { text: 'Aguardando',
                   action: 'cancel_friend_request' }
  end

  def on_cancel_friend_request(sender_id, receiver_id)
    notification = Notification.find_by(sender_id: sender_id, receiver_id: receiver_id, type: :friend_request)
    notification.destroy

    render json: { text: 'Adicionar amigo',
                   action: 'friend_request' }
  end

  def on_remove_friend(sender_id, receiver_id)
    notification = Notification.find_by(sender_id: receiver_id, receiver_id: sender_id, type: :friend_request)
    notification.destroy

    render json: { text: 'Adicionar amigo',
                   action: 'friend_request' }
  end

  def on_accept_friend(sender_id, receiver_id)
    notification_sender = User.find(sender_id)
    notification = Notification.find_by(sender_id: receiver_id, receiver_id: sender_id, type: :friend_request)
    notification.update_attributes(answer: :approved)

    Notification.create(
      sender_id: sender_id,
      receiver_id: receiver_id,
      type: :accept_friend_request,
      message: "#{link_to notification_sender, notification_sender.name} aceitou seu pedido de amizade"
    )
  end

  def on_decline_friend(sender_id, receiver_id)
    notification_sender = User.find(sender_id)
    notification = Notification.find_by(sender_id: receiver_id, receiver_id: sender_id, type: friend_request)
    notification.update_attributes(answer: :declined)
  end

  # Filtering

  def paginated_notifications
    notifications.page(params[:page]).per(PER_PAGE)
  end
end
