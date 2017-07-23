# frozen_string_literal: true

module NotificationsHelper
  def notification_message_str(notification, role)
    sender = notification.sender
    message_str = ""

    message_str = "#{link_to sender.name, url_for([role, sender])} te enviou uma solicitação de amizade!" if notification.waiting? && notification.friend_request?
    message_str = "#{link_to sender.name, url_for([role, sender])} aceitou seu pedido de amizade" if notification.accept_friend_request?

    message_str.html_safe
  end
end
