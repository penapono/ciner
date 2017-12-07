# frozen_string_literal: true

class AccountUpdateMailer < ApplicationMailer
  default from: "ciner@gmail.com"

  def account_update_mail(email)
    mail(to: email, subject: "Seu cadastro foi atualizado com sucesso!", reply_to: 'ciner@gmail.com')
  end
end
