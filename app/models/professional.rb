# frozen_string_literal: true
class Professional < ActiveRecord::Base
  include Searchables::Professional

  # Associations
  belongs_to :user
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :set_function

  # Validations
  validates :name,
            :set_function,
            presence: true

  # gender
  # 0: Men, 1: Women, 2: Other
  enum gender: { men: 0, women: 1, other: 2 }

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true
  delegate :name, to: :country, allow_nil: true, prefix: true
  delegate :name, to: :set_function, allow_nil: true, prefix: true

  # Callbacks
  before_save :update_address
  before_save :update_age

  # Aliases
  alias_attribute :title_str, :name
  alias_attribute :text, :title_str

  # Uploaders
  mount_uploader :avatar, ProfessionalAvatarUploader

  def title_str
    name
  end

  def self.localized_genders
    genders.map { |k, _w| [human_attribute_name("gender.#{k}"), k] }
  end

  def gender_str
    return "Não informado" unless gender
    User.human_attribute_name("gender.#{gender}")
  end

  # Scopes

  def self.by_gender(gender)
    where(gender: gender)
  end

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
    result = result.by_gender(genders[params[:gender]]) if params[:gender].present?
    result = result.by_country(params[:country]) if params[:country].present?
    result = result.by_state(params[:state]) if params[:state].present?
    result = result.by_city(params[:city]) if params[:city].present?

    result
  end

  def tmdb_gender(tmdb)
    return 0 if tmdb == 2
    1
  end

  def api_transform
    object = self

    tmdb_api_key = "8802a6c6583ac6edc44bea8d577baa97"

    tmdb_id = object.tmdb_id

    tmdb_person_url = "https://api.themoviedb.org/3/person/#{tmdb_id}?api_key=#{tmdb_api_key}&language=pt-BR"

    url = URI(tmdb_person_url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    response = http.request(request)

    body = response.read_body

    result = JSON.parse(body)

    object.biography = result["biography"]
    object.birthday = begin
                        Date.parse(result["birthday"])
                      rescue
                        nil
                      end

    object.deathday = begin
                        Date.parse(result["deathday"])
                      rescue
                        nil
                      end

    object.gender = tmdb_gender(result["gender"])

    object.imdb_id = result["imdb_id"]

    object.name = result["name"]

    object.place_of_birth = result["place_of_birth"]

    unless object.biography
      tmdb_person_url = "https://api.themoviedb.org/3/person/#{tmdb_id}?api_key=#{tmdb_api_key}&language=en-US"

      url = URI(tmdb_person_url)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request.body = "{}"

      response = http.request(request)

      body = response.read_body

      result = JSON.parse(body)

      object.biography = "(Disponível apenas em inglês) #{result['biography']}"
    end

    object.save(validate: false)
  end

  private

  def update_address
    return unless city
    self.state_id = city.state.id
    self.country_id = state.country.id
  end

  def update_age
    self.age = 0
    return unless birthday
    now = Time.now.utc.to_date
    self.age = now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end
end
