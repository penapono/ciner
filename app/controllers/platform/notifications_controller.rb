# frozen_string_literal: true

module Platform
  class NotificationsController < PlatformController
    include Platform::NotificationsBreadcrumb

    # exposes
    expose(:notifications) { Notification.for_user(current_user) }

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
