namespace :duplicates do
  desc 'Legends!'

  task search_and_destroy: :environment do
    h = Movie.select(:original_title, :year).group(:original_title, :year).having("count(*) > 1").size

    h.keys.each do |h|
      original_title = h.first
      year = h.second
      movies = Movie.where(original_title: original_title, year: year)

      movie_comparatives = Hash.new
      movies.each do |movie|
        movie_comparatives[movie] = movie.filmable_professionals.count
      end

      movie_comparatives = movie_comparatives.sort_by { |_k, v| v }.to_h

      movies_to_destroy = movie_comparatives.keys[1..movie_comparatives.count-1]
      unless movies_to_destroy.blank?
        movies_to_destroy.each do |movie_destroy|
          puts "Destroying ##{movie_destroy.id} #{movie_destroy.original_title}"
          movie_destroy.destroy
        end
      end
    end
  end
end
