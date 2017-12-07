# frozen_string_literal: true

class RememberPasswordMailer < ApplicationMailer
  default from: "ciner@gmail.com"

  def remember_password_mail(email)
    mail(to: email, subject: "Redefinir Senha", reply_to: 'ciner@gmail.com')
  end
end
