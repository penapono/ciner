# frozen_string_literal: true
class Visit < ActiveRecord::Base
  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :controller

  def resource_name
    (controller || "").gsub(/.*\//, '').singularize
  end

  def resource_path
    (controller || "").gsub(/\/[^\/]+$/, '').split('/')
  end

  def self.resource_count(controller, id)
    Visit.where("controller like ? AND resource_id = ?", "%#{controller}%", id).count
  end
end
