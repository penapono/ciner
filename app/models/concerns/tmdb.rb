# frozen_string_literal: true

module Tmdb
  extend ActiveSupport::Concern

  API_KEY   = "8802a6c6583ac6edc44bea8d577baa97"
  BASE_URL  = "https://api.themoviedb.org/3"
  LANGUAGE  = "language=pt-BR"

  included do
    def is_serie?(object)
      object.class.to_s == "Serie"
    end

    def object_base_url
      is_serie?(self) ? "#{BASE_URL}/tv" : "#{BASE_URL}/movie"
    end

    # API

    def start_tmdb(object)
      title = object.original_title.delete("\"")

      title =~ /(\w*(?:\w\W*)*)\((\d+)\)/

      title_str = Regexp.last_match(1)
      year_str = Regexp.last_match(2)

      title_str = title_str.blank? ? title : title_str.strip

      year_str = begin
                  Integer(year_str)
                rescue
                  is_serie?(object) ? object.start_year : object.year
                end

      tmdb_query = title_str

      tmdb_url = if is_serie?(object)
                   "#{BASE_URL}/search/tv?api_key=#{API_KEY}&#{LANGUAGE}&query=#{tmdb_query}&year=#{year_str}"
                 else
                   "#{BASE_URL}/search/movie?api_key=#{API_KEY}&#{LANGUAGE}&query=#{tmdb_query}&year=#{year_str}"
                  end

      tmdb_url = URI(URI.encode(tmdb_url))

      http = Net::HTTP.new(tmdb_url.host, tmdb_url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(tmdb_url)
      request.body = "{}"

      response = http.request(request)

      body = response.read_body

      result = JSON.parse(body)

      result["results"]&.first
    end

    def api_transform
      object = self

      # unless object.lock_updates? # && !Rails.env.development?
      #   tmdb_result = start_tmdb(object)

      #   if tmdb_result
      #     object.synopsis = tmdb_result["overview"]

      #     object.tmdb_id = tmdb_result["id"]

      #     object.title = if is_serie?(object)
      #                      tmdb_result["name"]
      #                    else
      #                      tmdb_result["title"]
      #                    end

      #     object.original_title = if is_serie?(object)
      #                               tmdb_result["original_name"]
      #                             else
      #                               tmdb_result["original_title"]
      #                             end

      #   end

      #   tmdb_id = object.tmdb_id

      #   tmdb_object = load_tmdb_object(tmdb_id)

      #   begin
      #     object.cover = load_poster(tmdb_object)
      #   rescue
      #     object.cover = ""
      #   end

      #   if is_serie?(object)
      #     object.number_of_seasons = tmdb_object["number_of_seasons"]
      #     tmdb_url = "#{object_base_url}/#{tmdb_id}/external_ids?api_key=#{API_KEY}&#{LANGUAGE}"

      #     tmdb_response = HTTParty.get(tmdb_url)

      #     tmdb_result = tmdb_response.parsed_response

      #     imdb_id = tmdb_result["imdb_id"]
      #   else
      #     imdb_id = tmdb_object["imdb_id"]
      #   end

      #   # OMDB

      #   imdb_id = imdb_id.gsub(/\s+/, "") unless imdb_id.blank?

      #   url = "http://www.omdbapi.com/?i=#{imdb_id}"

      #   uri = URI.parse(url)

      #   if uri.is_a?(URI::HTTP)
      #     response = HTTParty.get(url)

      #     response = response.parsed_response

      #     response_status = response["Response"]

      #     if response_status == "True"
      #       omdb_id = imdb_id.gsub(/\s+/, "") unless imdb_id.blank?

      #       object.omdb_id = omdb_id

      #       object.release = begin
      #                         Date.parse(response["Released"])
      #                       rescue
      #                         nil
      #                       end

      #       object.length = response["Runtime"]

      #       object.omdb_directors = response["Director"]

      #       object.omdb_writers = response["Writer"]

      #       object.omdb_actors = response["Actors"]

      #       object.omdb_genre = response["Genre"]

      #       countries = tmdb_object["production_countries"]

      #       countries_str = []

      #       unless countries.blank?
      #         countries.each do |country|
      #           country_name = country["name"]
      #           countries_str << country_name
      #         end
      #       end

      #       countries_str = countries_str.join(", ")

      #       object.countries = countries_str

      #       if is_serie?(object)
      #         object.start_year = response["Year"]
      #       else
      #         object.year = response["Year"]
      #       end

      #       if object.cover.blank?
      #         begin
      #           object.cover = load_omdb_cover(response["Poster"])
      #         rescue
      #           object.cover = ""
      #         end
      #       end
      #     end
      #   end

      #   imdb_brazilian_page = load_imdb_brazilian_page(imdb_id)

      #   object.brazilian_release = load_brazilian_release(imdb_brazilian_page)

      #   imdb_title = load_brazilian_title(imdb_brazilian_page)

      #   object.title = imdb_title unless imdb_title.blank?

      #   object.title = object.title.delete("\"") if object.title

      #   if object.original_title
      #     object.original_title = object.original_title.delete("\"")
      #   end

      #   object.trailer = load_trailer

      #   object.omdb_rated = load_rating

      #   omdb_country = response["Country"]

      #   object.lock_updates = true

      #   object.save(validate: false)

      # end

      tmdb_id = object.tmdb_id

      unless object.lock_updates?
        unless tmdb_id.blank?
          load_professionals(object, tmdb_id)

          load_seasons(object, tmdb_id) if is_serie?(object)
        end

        object.lock_updates = true

        object.save(validate: false)
      end
    rescue
    end

    def load_omdb_cover(omdb_poster)
      cover = ""

      cover = begin
                open(omdb_poster)
              rescue
                ""
              end

      cover
      # rescue
    end

    def load_tmdb_object(tmdb_id)
      url = URI("#{object_base_url}/#{tmdb_id}?language=pt-BR&api_key=#{API_KEY}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request.body = "{}"

      response = http.request(request)

      body = response.read_body

      result = JSON.parse(body)
    end

    def load_poster(tmdb_object)
      cover = ""

      result = tmdb_object

      imdb_poster = result["poster_path"]

      cover = begin
                open("https://image.tmdb.org/t/p/w500#{imdb_poster}")
              rescue
                ""
              end

      cover
      # rescue
    end

    def load_professionals(object, tmdb_id)
      tmdb_cast_url = "#{object_base_url}/#{tmdb_id}/credits?api_key=#{API_KEY}"

      tmdb_response = HTTParty.get(tmdb_cast_url)

      tmdb_response = tmdb_response.parsed_response

      cast = tmdb_response["cast"]

      crew = tmdb_response["crew"]

      load_actors(object, cast) if cast

      load_crew(object, crew) if crew
      # rescue
    end

    def load_rating
      loaded_rating = ""

      imdb_rating = "http://www.imdb.com/title/#{omdb_id}/parentalguide"

      page = HTTParty.get(imdb_rating)

      parsed_page = Nokogiri::HTML(page)

      ratings = parsed_page.css('.info-content')

      return "" unless ratings && ratings.text

      array = ratings.text.split("\n")

      ratings = array.last

      return "" unless ratings

      ratings_array = ratings.split("/").map(&:strip)

      ratings_array.each do |rating|
        if rating.include? "Brazil"
          omdb_rated = rating.gsub("Brazil:", "")

          if omdb_rated
            loaded_rating = omdb_rated
            break
          end
        end
      end

      loaded_rating
      # rescue
    end

    def load_trailer
      trailer = ""

      begin
        tmdb_video_url = "#{object_base_url}/#{tmdb_id}/videos?api_key=#{API_KEY}&#{LANGUAGE}"

        tmdb_response = HTTParty.get(tmdb_video_url)

        tmdb_response = tmdb_response.parsed_response

        tmdb_result = tmdb_response["results"].first

        video_key = tmdb_result["key"]

        trailer = "https://www.youtube.com/embed/" + video_key

        return trailer unless video_key.blank?
      rescue
        video_key = nil
      end

      begin
        tmdb_video_url = "#{object_base_url}/#{tmdb_id}/videos?api_key=#{API_KEY}"

        tmdb_response = HTTParty.get(tmdb_video_url)

        tmdb_response = tmdb_response.parsed_response

        tmdb_result = tmdb_response["results"].first

        video_key = tmdb_result["key"]

        trailer = "https://www.youtube.com/embed/" + video_key

        return trailer unless video_key.blank?
      rescue
        video_key = nil
      end

      unless video_key
        imdb_url = "http://www.imdb.com/title/#{omdb_id}"

        page = HTTParty.get(imdb_url)

        parsed_page = Nokogiri::HTML(page)

        trailer = parsed_page.css('.slate_button.prevent-ad-overlay.video-modal')

        href_element = trailer.first

        if href_element
          array = href_element.first
          array.delete("href")
          omdb_trailer = array[0]
          omdb_trailer = "www.imdb.com#{omdb_trailer}"
          omdb_trailer = omdb_trailer.split("?").first
          omdb_trailer = "http://#{omdb_trailer}/imdb/embed?autoplay=false&width=480"

          trailer = omdb_trailer

          return trailer unless omdb_trailer.blank?
        end
      end

      trailer
      # rescue
    end

    def load_imdb_brazilian_page(omdb_id)
      imdb_release_info_url = "http://www.imdb.com/title/#{omdb_id}/releaseinfo"

      page = HTTParty.get(imdb_release_info_url)

      Nokogiri::HTML(page)
    end

    def load_brazilian_release(parsed_page)
      omdb_brazilian_release = ""

      # Lançamento Brasil

      odd_rows = parsed_page.css('.subpage_data.spFirst').css('.odd')
      even_rows = parsed_page.css('.subpage_data.spFirst').css('.even')

      rows = odd_rows + even_rows

      rows.each do |row|
        if row.text.include? "Brazil"
          omdb_brazilian_release = nil
          array = row.text.split("\n").map(&:strip)
          array.delete("")
          array.delete("Brazil")
          array.each do |element|
            omdb_brazilian_release = begin
                                       Date.parse(element)
                                     rescue
                                       nil
                                     end
            break if omdb_brazilian_release
          end
        end
      end

      omdb_brazilian_release
      # rescue
    end

    def load_brazilian_title(parsed_page)
      omdb_brazilian_title = ""

      # Nome Brasil

      odd_rows = parsed_page.css('.subpage_data.spEven2Col').css('.odd')
      even_rows = parsed_page.css('.subpage_data.spEven2Col').css('.even')

      rows = odd_rows + even_rows

      rows.each do |row|
        if row.text.include? "Brazil"
          array = row.text.split("\n").map(&:strip)
          array.delete("")
          array.delete("Brazil")
          array.delete("Brazil (alternative title)")
          array.delete("Brazil (complete title)")
          array.delete("Brazil (short title)")
          omdb_brazilian_title = array[0] unless array.empty?
          return omdb_brazilian_title unless omdb_brazilian_title.blank?
        end
      end

      omdb_brazilian_title
      # rescue
    end

    def load_crew(object, crew)
      return unless crew

      crew.each do |person|
        job = person["job"]

        set_function = SetFunction.find_or_create_by(name: job)

        name = person["name"]

        tmdb_id = person["id"]

        professional = Professional.find_or_initialize_by(
          name: name,
          tmdb_id: tmdb_id
        )

        avatar_url = person["profile_path"]

        if avatar_url && !avatar_url.empty? && avatar_url != "N/A" && avatar_url
          begin
            avatar = open("https://image.tmdb.org/t/p/w500#{avatar_url}")
            professional.avatar = avatar if avatar
          rescue
          end
        end

        professional.save(validate: false)

        filmable_professional = FilmableProfessional.find_or_initialize_by(
          filmable_type: object.class.to_s,
          filmable_id: object.id,
          professional_id: professional.id,
          set_function_id: set_function.id
        )

        filmable_professional.save(validate: false)
      end
      # rescue
    end

    def load_actors(object, cast)
      return unless cast

      set_function = SetFunction.find_by(name: "Elenco")

      cast.each do |actor|
        character = actor["character"]

        name = actor["name"]
        tmdb_id = actor["id"]

        professional = Professional.find_or_initialize_by(
          name: name,
          tmdb_id: tmdb_id
        )

        avatar_url = actor["profile_path"]

        if avatar_url && !avatar_url.empty? && avatar_url != "N/A" && avatar_url
          begin
            avatar = open("https://image.tmdb.org/t/p/w500#{avatar_url}")
            professional.avatar = avatar if avatar
          rescue
          end
        end

        professional.save(validate: false)

        filmable_professional = FilmableProfessional.find_or_initialize_by(
          filmable_type: object.class.to_s,
          filmable_id: object.id,
          professional_id: professional.id,
          set_function_id: set_function.id,
          observation: character
        )

        filmable_professional.save(validate: false)
      end
      # rescue
    end

    def load_seasons(serie, serie_tmdb_id)
      seasons = serie.number_of_seasons.to_i

      (1..seasons).each do |season|
        load_season(serie, serie_tmdb_id, season)
      end
      # rescue
    end

    def load_season(serie, serie_tmdb_id, season)
      url = URI("#{object_base_url}/#{serie_tmdb_id}/season/#{season}?api_key=#{API_KEY}&#{LANGUAGE}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request.body = "{}"

      response = http.request(request)

      body = response.read_body

      result = JSON.parse(body)

      season_number = result["season_number"]

      name = result["name"]

      overview = result["overview"]

      air_date = result["air_date"]

      tmdb_id = result["id"]

      season_number = result["season_number"]

      number_of_episodes = begin
                             result["episodes"].count
                           rescue
                             0
                           end

      serie_season = SerieSeason.find_or_initialize_by(
        serie: serie,
        season_number: season_number
      )

      serie_season.name = name
      serie_season.overview = overview
      serie_season.air_date = begin
                                Date.parse(air_date)
                              rescue
                                nil
                              end
      serie_season.tmdb_id = tmdb_id
      serie_season.number_of_episodes = number_of_episodes

      if serie_season.number_of_episodes > 0
        load_episodes(serie, serie_season, serie_tmdb_id, tmdb_id)
      end

      serie_season.save(validate: false)
      # rescue
    end

    def load_episodes(serie, season, serie_tmdb_id, _season_tmdb_id)
      episodes = season.number_of_episodes.to_i

      (1..episodes).each do |episode|
        load_episode(serie, serie_tmdb_id, season, episode)
      end
      # rescue
    end

    def load_episode(serie, serie_tmdb_id, season, episode)
      url = URI("#{object_base_url}/#{serie_tmdb_id}/season/#{season.season_number}/episode/#{episode}?api_key=#{API_KEY}&#{LANGUAGE}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request.body = "{}"

      response = http.request(request)

      body = response.read_body

      result = JSON.parse(body)

      air_date = result["air_date"]

      episode_number = result["episode_number"]

      name = result["name"]

      overview = result["overview"]

      tmdb_id = result["id"]

      serie_season_episode = SerieSeasonEpisode.find_or_initialize_by(
        serie: serie,
        serie_season: season,
        episode_number: episode_number
      )

      serie_season_episode.name = name
      serie_season_episode.overview = overview
      serie_season_episode.air_date = begin
                                Date.parse(air_date)
                              rescue
                                nil
                              end
      serie_season_episode.tmdb_id = tmdb_id

      serie_season_episode.save(validate: false)
      # rescue
    end
  end
end
