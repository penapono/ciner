require 'httparty'

namespace :movie_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    # Movie.where(lock_updates: false).first(20).each do |movie|

    Movie.where("lock_updates = false").order(year: :desc).first(1000).each(&:api_transform)
    # Movie.where("year < 1951 AND lock_updates = false").order(year: :asc).first(600)
    # Movie.where("lock_updates = false").order(year: :desc) unless collection.any?
  end
end
