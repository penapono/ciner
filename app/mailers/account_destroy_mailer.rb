# frozen_string_literal: true

class AccountDestroyMailer < ApplicationMailer
  default from: "ciner@gmail.com"

  def account_destroy_mail(email)
    mail(to: email, subject: "Hasta La vista baby!", reply_to: 'ciner@gmail.com')
  end
end
