require 'httparty'

namespace :savitar do
  desc "I'm the fastest script alive!"

  task update: :environment do
    Movie.current_playing.first(20).each(&:api_transform)
    Serie.current_playing.first(20).each(&:api_transform)
  end
end
