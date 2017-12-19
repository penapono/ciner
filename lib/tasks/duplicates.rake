# namespace :duplicates do
#   desc 'Legends!'

#   task search_and_destroy: :environment do
#     h = Serie.select(:title, :year).group(:title, :year).having("count(*) > 1").size

#     h.keys.each do |h|
#       title = h.first
#       year = h.second
#       series = Serie.where(title: title, year: year)

#       serie_comparatives = Hash.new
#       series.each do |serie|
#         serie_comparatives[serie] = serie.filmable_professionals.count
#       end

#       serie_comparatives = serie_comparatives.sort_by { |_k, v| v }.to_h

#       series_to_destroy = serie_comparatives.keys[1..serie_comparatives.count-1]
#       unless series_to_destroy.blank?
#         series_to_destroy.each do |serie_destroy|
#           puts "Destroying ##{serie_destroy.id} #{serie_destroy.title}"
#           serie_destroy.destroy
#         end
#       end
#     end
#   end
# end

namespace :duplicates do
  task search_and_destroy: :environment do
    found_series =
      Serie
      .order(start_year: :desc)
      .select(:title)
      .group(:title)
      .having("count(*) > 1").size

    # se precisar ordenar por número de repetições
    # found_series = found_series.sort_by { |_k, v| v }.reverse.to_h

    already_counted = SerieDuplicate.pluck(:title)

    found_series.reject! { |key| already_counted.include?(key) }

    found_series.keys.each do |found_serie|
      title = found_serie
      series_same_title = Serie.where(title: title).order(start_year: :asc)

      serie_comparatives = {}
      series_same_title.each do |serie|
        serie_comparatives[serie] = serie.directors.order(id: :asc).pluck(:id)
      end

      number_duplicates = serie_comparatives.keys.count
      number_directors_duplicates = serie_comparatives.values.uniq.count

      if number_duplicates > number_directors_duplicates
        SerieDuplicate.find_or_create_by(
          title: title,
          available_years: series_same_title.pluck(:start_year).to_sentence,
          count: number_duplicates
        )
      end
    end
  end
end
