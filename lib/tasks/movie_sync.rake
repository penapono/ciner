require 'httparty'

namespace :movie_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    Movie.where(lock_updates: false).first(20).each do |movie|
      movie.api_transform
    end
  end
end
