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
                  elsif notification.ciner_production_waiting?
                    ciner_production = CinerProduction.find(notification.message.to_i)
                    "Sua produção independente #{link_to ciner_production.title_str, url_for([role, ciner_production])} está aguardando aprovação!"
                  elsif notification.ciner_production_pending?
                    ciner_production = CinerProduction.find(notification.message.to_i)
                    "#{link_to sender.name, url_for([role, sender])} criou uma produção independente #{link_to ciner_production.title_str, url_for([role, ciner_production])}"
                  elsif notification.ciner_production_approved?
                    ciner_production = CinerProduction.find(notification.message.to_i)
                    "Sua produção independente #{link_to ciner_production.title_str, url_for([role, ciner_production])} foi aprovada! Parabéns!"
                  elsif notification.ciner_production_reproved?
                    ciner_production = CinerProduction.find(notification.message.to_i)
                    "Sua produção independente #{link_to ciner_production.title_str, url_for([role, ciner_production])} foi reprovada. Por favor, #{link_to 'edite-a', url_for([:edit, role, ciner_production])} para que possa ser aceita"
                  else
                    ""
                  end

    message_str.html_safe
  end
end
