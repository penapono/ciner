namespace :send_birthday_mails do
  desc 'Send birthday e-mails'

  task congrats: :environment do
    User
      .birthdays
      .find_each(batch_size: 1000)
      .each do |birthday_user|
        BirthdayMailer.birthday_email(birthday_user).deliver_now
    end
  end
end


