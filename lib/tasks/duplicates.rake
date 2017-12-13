# namespace :duplicates do
#   desc 'Legends!'

#   task search_and_destroy: :environment do
#     h = Movie.select(:original_title, :year).group(:original_title, :year).having("count(*) > 1").size

#     h.keys.each do |h|
#       original_title = h.first
#       year = h.second
#       movies = Movie.where(original_title: original_title, year: year)

#       movie_comparatives = Hash.new
#       movies.each do |movie|
#         movie_comparatives[movie] = movie.filmable_professionals.count
#       end

#       movie_comparatives = movie_comparatives.sort_by { |_k, v| v }.to_h

#       movies_to_destroy = movie_comparatives.keys[1..movie_comparatives.count-1]
#       unless movies_to_destroy.blank?
#         movies_to_destroy.each do |movie_destroy|
#           puts "Destroying ##{movie_destroy.id} #{movie_destroy.original_title}"
#           movie_destroy.destroy
#         end
#       end
#     end
#   end
# end

namespace :duplicates do
  task search_and_destroy: :environment do
    found_movies =
      Movie
      .order(year: :desc)
      .select(:original_title)
      .group(:original_title)
      .having("count(*) > 1").size

    # se precisar ordenar por número de repetições
    # found_movies = found_movies.sort_by { |_k, v| v }.reverse.to_h

    already_counted = MovieDuplicate.pluck(:title)

    found_movies.reject! { |key| already_counted.include?(key) }

    found_movies.keys.each do |found_movie|
      original_title = found_movie
      movies_same_title = Movie.where(original_title: original_title).order(year: :asc)

      movie_comparatives = {}
      movies_same_title.each do |movie|
        movie_comparatives[movie] = movie.directors.order(id: :asc).pluck(:id)
      end

      number_duplicates = movie_comparatives.keys.count
      number_directors_duplicates = movie_comparatives.values.uniq.count

      if number_duplicates > number_directors_duplicates
        MovieDuplicate.find_or_create_by(
          title: original_title,
          available_years: movies_same_title.pluck(:year).to_sentence,
          count: number_duplicates
        )
      end
    end
  end
end
