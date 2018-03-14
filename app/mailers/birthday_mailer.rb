# frozen_string_literal: true

class BirthdayMailer < ApplicationMailer
  default from: "ciner@gmail.com"

  def birthday_email(user)
    attachments.inline["asanoha.png"] = File.read("#{Rails.root}/app/assets/images/asanoha.png")
    attachments.inline["instagram.png"] = File.read("#{Rails.root}/app/assets/images/instagram2.png")
    attachments.inline["facebook.png"] = File.read("#{Rails.root}/app/assets/images/facebook.png")
    attachments.inline["logo.jpg"] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
    @user = user
    mail(to: user.email, subject: "Parabéns!", reply_to: "ciner@gmail.com")
  end
end
