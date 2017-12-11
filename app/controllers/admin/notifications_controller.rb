# frozen_string_literal: true

module Admin
  class NotificationsController < AdminController
    include Admin::NotificationsBreadcrumb

    # exposes
    expose(:notifications) do
      Notification.for_user(current_user).order(created_at: :desc)
    end

    PER_PAGE = 50

    def index
      return if notifications.blank?
      self.notifications = paginated_notifications
      notifications.update_all(status: 1) if notifications.any? # read all notifications
    end

    private

    # Filtering

    def paginated_notifications
      notifications.page(params[:page]).per(PER_PAGE)
    end
  end
end
