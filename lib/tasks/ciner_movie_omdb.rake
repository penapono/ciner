require 'httparty'

namespace :ciner_movie_omdb do

  desc 'Make Ciner great Again!'

  task create_or_update: :environment do
    Movie.where(tmdb_id: nil).find_each do |serie|
      serie.api_transform
    end
  end
end
