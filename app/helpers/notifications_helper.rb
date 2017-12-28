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
                  elsif notification.trophy?
                    notification.message
                  elsif notification.contact?
                    "#{link_to sender.name, url_for([role, sender])} se interessou pelo seu currículo e quer entrar em contato com você. Você deseja informar seu e-mail de contato?"
                  elsif notification.accept_contact?
                    "#{link_to sender.name, url_for([role, sender])} aceitou informar o email de contato: #{sender.email}. Agora é com vocês. Que esta parceria renda grandes produções!"
                  else
                    ""
                  end

    message_str.html_safe
  end
end
