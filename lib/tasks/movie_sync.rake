require 'httparty'

namespace :movie_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    # Movie.where(lock_updates: false).first(20).each do |movie|

    Movie.where("year > 2009 AND year < 2020 AND lock_updates = false").order(year: :desc).first(600).each do |movie|
      movie.api_transform
    end
    # Movie.where("year < 1951 AND lock_updates = false").order(year: :asc).first(600)
    # Movie.where("lock_updates = false").order(year: :desc) unless collection.any?
  end
end
