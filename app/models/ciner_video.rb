# frozen_string_literal: true
class CinerVideo < ActiveRecord::Base
  include Searchables::CinerVideo

  # Associations
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :age_range

  belongs_to :studio

  # Ciner Movie
  belongs_to :approver, class_name: 'User'
  belongs_to :owner, class_name: 'User'

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
end
