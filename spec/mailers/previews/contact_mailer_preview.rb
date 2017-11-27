# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    ContactMailer.sample_email(User.find(5))
  end
end
