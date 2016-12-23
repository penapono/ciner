# frozen_string_literal: true
class UserMailer < ApplicationMailer
  default from: 'ciner@gmail.com'

  def sample_email(user)
    @user = user
    mail(to: user.email, subject: 'test mail')
  end
end
