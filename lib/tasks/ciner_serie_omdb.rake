require 'httparty'

namespace :ciner_serie_omdb do

  desc 'Make Ciner great Again!'

  task create_or_update: :environment do
    Serie.where(lock_updates: false).first(12).each do |serie|
      serie.api_transform
      sleep 1
    end
  end
end
