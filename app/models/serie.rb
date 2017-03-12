# frozen_string_literal: true
class Serie < ActiveRecord::Base
  include Searchables::Serie
  include FilmProfitable

  # Associations
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :age_range

  belongs_to :studio

  has_many :critics, as: :filmable

  has_many :critics, as: :filmable
  has_many :filmable_professionals, as: :filmable
  has_many :professionals, through: :filmable_professionals

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Validations
  validates :original_title,
            :start_year,
            :length,
            presence: true

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true
  delegate :name, to: :country, allow_nil: true, prefix: true

  # Aliases
  alias_attribute :text, :title_str

  # Scopes
  def self.by_city(city)
    where(city: city)
  end

  def self.by_state(id)
    where(state_id: id)
  end

  def self.by_country(id)
    where(country_id: id)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_country(params[:country]) if params[:country].present?
    result = result.by_state(params[:state]) if params[:state].present?
    result = result.by_city(params[:city]) if params[:city].present?

    result
  end

  def original_title_str
    return original_title unless start_year
    original_title.gsub("(#{start_year})", "")
  end

  # API

  def api_transform
    object = self
    title = object.original_title

    tmdb_api_key = "8802a6c6583ac6edc44bea8d577baa97"

    title = title.delete("\"")

    title =~ /(\w*(?:\s\w*)*)\((\d+)\)/

    title_str = Regexp.last_match(1)
    year_str = Regexp.last_match(2)

    year_str = begin
                Integer(year_str)
              rescue
                object.start_year
              end

    tmdb_query = title_str

    tmdb_url = "https://api.themoviedb.org/3/search/tv?api_key=#{tmdb_api_key}&language=pt-BR&query=#{tmdb_query}&page=1&first_air_date_year=#{year_str}"

    tmdb_url = URI.encode(tmdb_url)

    tmdb_response = HTTParty.get(tmdb_url)

    tmdb_response = tmdb_response.parsed_response

    # TMDB
    tmdb_results = tmdb_response["results"]

    tmdb_result = tmdb_results.first

    tmdb_plot = tmdb_result["overview"]

    tmdb_id = tmdb_result["id"]

    tmdb_movie_url = "https://api.themoviedb.org/3/tv/#{tmdb_id}?api_key=#{tmdb_api_key}&language=pt-BR"

    tmdb_response = HTTParty.get(tmdb_url)

    tmdb_response = tmdb_response.parsed_response

    tmdb_results = tmdb_response["results"]

    tmdb_result = tmdb_results.first

    url = URI("https://api.themoviedb.org/3/tv/#{tmdb_id}?language=pt-BR&api_key=#{tmdb_api_key}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    response = http.request(request)

    body = response.read_body

    result = JSON.parse(body)

    imdb_poster = result["poster_path"]

    if imdb_poster && !imdb_poster.empty? && imdb_poster != "N/A" && imdb_poster
      cover = open("https://image.tmdb.org/t/p/w500#{imdb_poster}")

      begin
        object.cover = cover if cover
      rescue
      end
    end

    tmdb_movie_url = "https://api.themoviedb.org/3/tv/#{tmdb_id}/external_ids?api_key=#{tmdb_api_key}&language=pt-BR"

    tmdb_response = HTTParty.get(tmdb_movie_url)

    tmdb_result = tmdb_response.parsed_response

    imdb_id = tmdb_result["imdb_id"]

    # OMDB

    url = "http://www.omdbapi.com/?i=#{imdb_id}"

    uri = URI.parse(url)

    if uri.is_a?(URI::HTTP)
      response = HTTParty.get(url)

      response = response.parsed_response

      response_status = response["Response"]

      if response_status == "True"
        # omdb_id = response["imdbID"]
        omdb_id = imdb_id

        object.omdb_id = omdb_id

        omdb_title = response["Title"]

        # OMDB

        omdb_year = response["Year"]

        omdb_released = begin
                          Date.parse(response["Released"])
                        rescue
                          nil
                        end

        omdb_runtime = response["Runtime"]

        omdb_genre = response["Genre"]

        omdb_directors = response["Director"]

        omdb_writers = response["Writer"]

        omdb_actors = response["Actors"]

        omdb_plot = response["Plot"]

        omdb_genre = response["Genre"]

        omdb_country = response["Country"]

        # object.original_title = omdb_title
        object.title = omdb_title
        object.start_year = omdb_year

        object.release = omdb_released if omdb_released

        object.length = omdb_runtime
        object.synopsis = tmdb_plot

        object.omdb_directors = omdb_directors

        object.omdb_writers = omdb_writers

        object.omdb_actors = omdb_actors

        object.omdb_genre = omdb_genre

        unless object.cover
          omdb_poster = response["Poster"]

          if omdb_poster && !omdb_poster.empty? && omdb_poster != "N/A" && omdb_poster
            cover = open(omdb_poster)

            begin
              object.cover ||= cover if cover
            rescue
            end
          end
        end

        imdb_release_info_url = "http://www.imdb.com/title/#{omdb_id}/releaseinfo"

        page = HTTParty.get(imdb_release_info_url)

        parsed_page = Nokogiri::HTML(page)

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
            object.brazilian_release = omdb_brazilian_release if omdb_brazilian_release
          end
        end

        # Nome Brasil

        odd_rows = parsed_page.css('.subpage_data.spEven2Col').css('.odd')
        even_rows = parsed_page.css('.subpage_data.spEven2Col').css('.even')

        rows = odd_rows + even_rows

        rows.each do |row|
          if row.text.include? "Brazil"
            omdb_brazilian_title = nil
            array = row.text.split("\n").map(&:strip)
            array.delete("")
            omdb_brazilian_title = array[1] unless array.empty?
            object.title = omdb_brazilian_title if omdb_brazilian_title
            break if object.title
          end
        end

        # Trailer

        begin
          tmdb_video_url = "https://api.themoviedb.org/3/tv/#{tmdb_id}/videos?api_key=#{tmdb_api_key}&language=pt-BR"

          tmdb_response = HTTParty.get(tmdb_video_url)

          tmdb_response = tmdb_response.parsed_response

          tmdb_result = tmdb_response["results"].first

          video_key = tmdb_result["key"]

          object.omdb_trailer = "https://www.youtube.com/embed/" + video_key
        rescue
          video_key = nil
        end

        # <iframe width="560" height="315" src="https://www.youtube.com/embed/lp00DMy3aVw" frameborder="0" allowfullscreen></iframe>

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

            object.omdb_trailer = omdb_trailer
          end
        end

        # Classificação Etária

        imdb_rating = "http://www.imdb.com/title/#{omdb_id}/parentalguide"

        page = HTTParty.get(imdb_rating)

        parsed_page = Nokogiri::HTML(page)

        ratings = parsed_page.css('.info-content')

        array = ratings.text.split("\n")

        ratings = array.last

        ratings_array = ratings.split("/").map(&:strip)

        ratings_array.each do |rating|
          if rating.include? "Brazil:"
            rating.gsub!("Brazil:", "")
            omdb_rated = rating
            break
          end
        end

        # Profissionais

        tmdb_cast_url = "https://api.themoviedb.org/3/tv/#{tmdb_id}/credits?api_key=#{tmdb_api_key}"

        tmdb_response = HTTParty.get(tmdb_cast_url)

        tmdb_response = tmdb_response.parsed_response

        cast = tmdb_response["cast"]

        crew = tmdb_response["crew"]

        load_actors(object, cast) unless object.actors.any?

        if object.directors.empty? || object.writers.empty?
          load_crew(object, crew)
        end

        object.save(validate: false)
      end
    end
  rescue
  end

  def load_crew(object, crew)
    set_function_director = SetFunction.find_by(name: "Direção")
    set_function_writer = SetFunction.find_by(name: "Roteiro")

    crew.each do |person|
      job = person["job"]

      if %w(Director Writer).include? job

        name = person["name"]

        if job == "Director"
          set_function = set_function_director
        elsif job == "Writer"
          set_function = set_function_writer
        end

        professional = Professional.find_or_initialize_by(
          name: name,
          set_function: set_function
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
          filmable_type: Serie,
          filmable_id: object.id,
          professional_id: professional.id,
          set_function_id: set_function.id
        )

        filmable_professional.save(validate: false)
      end
    end
  end

  def load_actors(object, cast)
    set_function = SetFunction.find_by(name: "Elenco")

    cast.each do |actor|
      character = actor["character"]

      name = actor["name"]

      professional = Professional.find_or_initialize_by(
        name: name,
        set_function: set_function
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
        filmable_type: Serie,
        filmable_id: object.id,
        professional_id: professional.id,
        set_function_id: set_function.id,
        observation: character
      )

      filmable_professional.save(validate: false)
    end
  end
end
