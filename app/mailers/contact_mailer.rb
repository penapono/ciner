# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  default from: "pedro.gnaponoceno@gmail.com"

  def contact_email(email, contact)
    attachments.inline["asanoha.png"] = File.read("#{Rails.root}/app/assets/images/asanoha.png")
    attachments.inline["instagram.png"] = File.read("#{Rails.root}/app/assets/images/instagram2.png")
    attachments.inline["facebook.png"] = File.read("#{Rails.root}/app/assets/images/facebook.png")
    attachments.inline["logo.jpg"] = File.read("#{Rails.root}/app/assets/images/logo.jpg")
    @contact = contact
    mail(to: email, subject: "[#{contact.subject_str}]", reply_to: contact.email)
  end
end
