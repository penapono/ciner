# frozen_string_literal: true

class AccountUpdateMailer < ApplicationMailer
  default from: "ciner@gmail.com"

  def account_update_mail(email)
    attachments.inline["asanoha.png"] = File.read("#{Rails.root}/app/assets/images/asanoha.png")
    attachments.inline["instagram.png"] = File.read("#{Rails.root}/app/assets/images/instagram2.png")
    attachments.inline["facebook.png"] = File.read("#{Rails.root}/app/assets/images/facebook.png")
    attachments.inline["logo.jpg"] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
    mail(to: email, subject: "Seu cadastro foi atualizado com sucesso!", reply_to: "ciner@gmail.com")
  end
end
