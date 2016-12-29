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

  private

  def update_address
    self.state_id = city.state.id
    self.country_id = state.country.id
  end

  def update_age
    self.age = 0 unless birthday
    now = Time.now.utc.to_date
    self.age = now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end
end
