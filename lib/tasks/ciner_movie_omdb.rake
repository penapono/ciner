require 'httparty'

namespace :ciner_movie_omdb do

  desc 'Make Ciner great Again!'

  task create_or_update: :environment do
    Movie.where(lock_updates: false).first(12).each do |movie|
      movie.api_transform
      sleep 1
    end
  end
end
