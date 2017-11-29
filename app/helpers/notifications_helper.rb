# frozen_string_literal: true

module NotificationsHelper
  def notification_message_str(notification, role)
    sender = notification.sender

    message_str = if notification.delate_ok?
                    "Sua denúncia foi analisada. Agradecemos a ajuda. Que a força esteja com você."
                  elsif notification.waiting? && notification.friend_request?
                    "#{link_to sender.name, url_for([role, sender])} te enviou uma solicitação de amizade!"
                  elsif notification.accept_friend_request?
                    "#{link_to sender.name, url_for([role, sender])} aceitou seu pedido de amizade"
                  else
                    ""
                  end

    message_str.html_safe
  end
end
