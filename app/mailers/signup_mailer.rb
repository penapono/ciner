# frozen_string_literal: true

class SignupMailer < ApplicationMailer
  default from: "ciner@gmail.com"

  def welcome_mail(email)
    mail(to: email, subject: "Bem-vindo, CINER!", reply_to: 'ciner@gmail.com')
  end
end
