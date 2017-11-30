require 'httparty'

namespace :movie_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    Movie.where(lock_updates: false).each(&:api_transform)
  end
end
