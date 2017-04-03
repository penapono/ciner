require 'httparty'

namespace :ciner_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    Movie.where(lock_updates: false).first(25).each do |movie|
      movie.api_transform
    end

    Serie.where(lock_updates: false).first(25).each do |serie|
      serie.api_transform
    end
  end
end
