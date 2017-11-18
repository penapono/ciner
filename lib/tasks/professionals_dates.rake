require 'httparty'

namespace :professionals_dates do
  desc 'Update professionals_dates'

  task update: :environment do
    Professional
      .where(lock_updates: false)
      .find_each(batch_size: 1000)
      .each(&:api_transform)
  end
end
