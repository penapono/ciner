# frozen_string_literal: true
class Movie < ActiveRecord::Base
  include Searchables::Movie
  include FilmProfitable

  # Associations
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :age_range

  belongs_to :studio

  has_many :critics, as: :filmable
  has_many :filmable_professionals, as: :filmable
  has_many :professionals, through: :filmable_professionals

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Validations
  validates :original_title,
            :year,
            :length,
            presence: true

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true
  delegate :name, to: :country, allow_nil: true, prefix: true
  delegate :name, to: :age_range, allow_nil: true, prefix: true

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
    return original_title unless year
    original_title.gsub("(#{year})", "")
  end

  # API

  def api_transform
    object = self
    title = object.original_title

    tmdb_api_key = "8802a6c6583ac6edc44bea8d577baa97"

    title =~ /(\w*(?:\s\w*)*)\((\d+)\)/

    title_str = Regexp.last_match(1)
    year_str = Regexp.last_match(2)

    year_str = begin
                Integer(year_str)
              rescue
                object.year
              end

    tmdb_query = title_str

    tmdb_url = "https://api.themoviedb.org/3/search/movie?api_key=#{tmdb_api_key}&language=pt-BR&query=#{tmdb_query}&page=1&include_adult=true&year=#{year}"

    tmdb_url = URI.encode(tmdb_url)

    tmdb_response = HTTParty.get(tmdb_url)

    tmdb_response = tmdb_response.parsed_response

    # TMDB
    tmdb_results = tmdb_response["results"]

    tmdb_result = tmdb_results.first

    tmdb_plot = tmdb_result["overview"]

    tmdb_id = tmdb_result["id"]

    tmdb_movie_url = "https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=#{tmdb_api_key}&language=pt-BR"

    tmdb_response = HTTParty.get(tmdb_url)

    tmdb_response = tmdb_response.parsed_response

    tmdb_results = tmdb_response["results"]

    tmdb_result = tmdb_results.first

    url = URI("https://api.themoviedb.org/3/movie/#{tmdb_id}?language=pt-BR&api_key=#{tmdb_api_key}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    response = http.request(request)

    body = response.read_body

    result = JSON.parse(body)

    imdb_id = result["imdb_id"]

    # OMDB

    url = "http://www.omdbapi.com/?i=#{imdb_id}"

    uri = URI.parse(url)

    if uri.is_a?(URI::HTTP)
      begin
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

          # EasyTranslate.translate(omdb_plot, :to => 'pt', :key => "AIzaSyD66z0ODjU0B65NUYZiTD-hwyQVgdCfu6Y")

          # response["Language"]

          omdb_country = response["Country"]

          # response["Awards"]

          omdb_poster = response["Poster"]

          # response["Metascore"]

          # response["imdbRating"]

          # response["imdbVotes"]

          # response["Type"]

          # response["Response"]

          # object.original_title = omdb_title
          object.title = omdb_title
          object.year = omdb_year

          object.release = omdb_released if omdb_released

          object.length = omdb_runtime
          object.synopsis = tmdb_plot

          # object.omdb_rated = omdb_rated

          object.omdb_directors = omdb_directors

          object.omdb_writers = omdb_writers

          object.omdb_actors = omdb_actors

          object.omdb_genre = omdb_genre

          if omdb_poster && !omdb_poster.empty? && omdb_poster != "N/A" && omdb_poster
            cover = open(omdb_poster)

            begin
              object.cover = cover if cover
            rescue
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
              array.delete("Brazil")
              omdb_brazilian_title = array[0] unless array.empty?
              object.title = omdb_brazilian_title if omdb_brazilian_title
            end
          end

          # Trailer

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

          # Classificação Etária

          imdb_rating = "http://www.imdb.com/title/#{omdb_id}/parentalguide"

          page = HTTParty.get(imdb_rating)

          parsed_page = Nokogiri::HTML(page)

          ratings = parsed_page.css('.info-content')

          array = ratings.text.split("\n")

          ratings = array.last

          ratings_array = ratings.split("/").map(&:strip)

          ratings_array.each do |rating|
            if rating.include? "Brazil"
              omdb_rated = rating.gsub("Brazil:", "")
              object.omdb_rated = omdb_rated
              break
            end
          end

          # Profissionais

          tmdb_cast_url = "https://api.themoviedb.org/3/movie/#{tmdb_id}/credits?api_key=#{tmdb_api_key}"

          tmdb_response = HTTParty.get(tmdb_cast_url)

          tmdb_response = tmdb_response.parsed_response

          cast = tmdb_response["cast"]

          crew = tmdb_response["crew"]

          # Google

          # friendly_omdb_plot = omdb_plot.gsub(/"/, '').gsub(",", "%2C").gsub(" ", "%20")

          # translate_url = "https://translate.google.com/#en/pt/#{friendly_omdb_plot}"

          # page = HTTParty.get(translate_url)

          # parsed_page = Nokogiri::HTML(page)

          # object.original_title = omdb_title

          object.save(validate: false)
        end
      rescue
      end
    end
  rescue
  end
end
