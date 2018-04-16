# frozen_string_literal: true

class SetFunction < ActiveRecord::Base
  include Searchables::SetFunction

  # Associations
  belongs_to :user

  # Validations
  validates :name,
            presence: true

  # Scope
  default_scope { order(name: :asc) }

  # Filter

  def self.filter_by(collection, _params)
    collection
  end

  def self.shrink
    all_duplicates = SetFunction.select(:name).group(:name).having("count(*) > 1")
    all_duplicates.each do |a_duplicate|
      origin = SetFunction.find_by(name: a_duplicate.name)
      duplicates = SetFunction.where(name: origin.name).where.not(id: origin.id)
      duplicates.each do |duplicate|
        origin.description += ", #{duplicate.description}"
        origin.save(validate: false)
        FilmableProfessional.where(set_function_id: duplicate.id).update_all(set_function_id: origin.id)
        Professional.where(set_function_id: duplicate.id).update_all(set_function_id: origin.id)
        duplicate.destroy
      end
    end
  end
end
