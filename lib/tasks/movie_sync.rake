require 'httparty'

namespace :movie_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    # Movie.where(lock_updates: false).first(20).each do |movie|

    collection = Movie.where("year > 2009 AND year < 2020 AND lock_updates = false").order(year: :desc)
    collection = Movie.where("year < 1951 AND lock_updates = false").order(year: :asc) unless collection.any?
    collection = Movie.where("lock_updates = false").order(year: :desc) unless collection.any?

    if collection.any?
      collection.first(600).each do |movie|
        movie.api_transform
      end
    end
  end
end
