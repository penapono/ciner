require 'httparty'

namespace :ciner_omdb do

  desc 'Make Ciner great Again!'

  task create_or_update: :environment do
    worked = 0
    not_worked = 0

    start = Time.now

    # Movie.where(id: 3989957).each do |movie|
    # 2766408
    # Movie.where(id: 2766408).each do |movie|
    Serie.all.each do |movie|
      title = movie.original_title

      title_str = title[0, title.length-6].gsub(/\P{ASCII}/, '').gsub("#", "")
      year_str = title[title.length - 5, 4]

      url = "http://www.omdbapi.com/?t=#{title_str}&y=#{year_str}&plot=short&r=json"

      uri = URI.parse(url)

      if uri.is_a?(URI::HTTP)
        begin
          response = HTTParty.get(url)

          # byebug

          response = response.parsed_response

          response_status = response["Response"]

          if response_status == "False"
            not_worked += 1
            # puts "Não funcionou para #{url}\n"
          else
            worked += 1

            omdb_title = response["Title"]

            omdb_year = response["Year"]

            omdb_rated = response["Rated"]

            omdb_released = Date.parse(response["Released"]) rescue nil

            omdb_runtime = response["Runtime"]

            omdb_genre = response["Genre"]

            omdb_director = response["Director"]

            # response["Writer"]

            omdb_actors = response["Actors"]

            omdb_plot = response["Plot"]

            # EasyTranslate.translate(omdb_plot, :to => 'pt', :key => "AIzaSyD66z0ODjU0B65NUYZiTD-hwyQVgdCfu6Y")

            # response["Language"]

            omdb_country = response["Country"]

            # response["Awards"]

            omdb_poster = response["Poster"]

            # response["Metascore"]

            # response["imdbRating"]

            # response["imdbVotes"]

            # response["imdbID"]

            # response["Type"]

            # response["Response"]

            # movie.original_title = omdb_title
            movie.title = omdb_title
            movie.start_year = omdb_year

            unless omdb_released
              movie.release = omdb_released
            end

            movie.length = omdb_runtime
            movie.synopsis = omdb_plot

            if omdb_poster && !omdb_poster.empty? && omdb_poster != "N/A" && omdb_poster
              cover = open(omdb_poster)

              begin
                movie.cover = cover if cover
              rescue
              end
            end

            movie.save(validate: false)
            # puts "Funcionou para #{url}!!\n"
          end
        rescue
          puts "Falhou na URI para filme #{movie.id}"
          not_worked += 1
        end
      else
        not_worked += 1
      end
    end

    # code to time
    finish = Time.now

    diff = finish - start

    puts "Funcionou para #{worked}/#{worked+not_worked}"
    puts "Não funcionou para #{not_worked}/#{worked+not_worked}"

    puts "\n\n\nDemorou #{diff/60} minutos!"
  end
end
