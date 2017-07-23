# frozen_string_literal: true

module Admin
  class NotificationsController < AdminController
    include Admin::NotificationsBreadcrumb

    # exposes
    expose(:notifications) { Notification.find_by(receiver_id: current_user.id) }

    PER_PAGE = 50

    def index
      return if notifications.blank?
      self.notifications = paginated_notifications
    end

    private

    # Filtering

    def paginated_notifications
      notifications.page(params[:page]).per(PER_PAGE)
    end
  end
end
