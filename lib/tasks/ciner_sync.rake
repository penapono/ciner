require 'httparty'

namespace :ciner_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    Movie.where(lock_updates: false).order(year: :desc).first(25).each do |movie|
      movie.api_transform
      sleep 1
    end

    Serie.where(lock_updates: false).order(year: :desc).first(25).each do |serie|
      serie.api_transform
      sleep 1
    end
  end
end
