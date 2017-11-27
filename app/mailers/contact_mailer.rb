# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  default from: "pedro.gnaponoceno@gmail.com"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end

  def contact_email(email, contact)
    @contact = contact
    mail(to: email, subject: "[#{contact.subject_str}]", reply_to: contact.email)
  end
end
