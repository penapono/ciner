require 'httparty'

namespace :serie_sync do
  desc 'Make Ciner great Again!'

  task update: :environment do
    Serie.where(lock_updates: false).first(20).each do |serie|
      serie.api_transform
    end
  end
end
