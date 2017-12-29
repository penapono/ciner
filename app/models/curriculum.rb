# frozen_string_literal: true

class Curriculum < ActiveRecord::Base
  include Searchables::Curriculum

  # Associations
  belongs_to :user
  has_many :curriculum_curriculum_functions, dependent: :destroy
  has_many :curriculum_photos, dependent: :destroy
  has_many :curriculum_files, dependent: :destroy
  has_many :curriculum_videos, dependent: :destroy
  has_many :curriculum_audios, dependent: :destroy

  # Validations
  validates :user_id,
            :play_name,
            presence: true

  # Nested
  accepts_nested_attributes_for :curriculum_curriculum_functions,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :curriculum_photos,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :curriculum_files,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :curriculum_videos,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :curriculum_audios,
                                allow_destroy: true,
                                reject_if: :all_blank

  # gender
  enum gender: { men: 0, women: 1, other: 2 }
  enum ethnicity: { white: 1, afrodescendant: 2, brown: 3, yellow: 4, indigenous: 5 }

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :nickname, to: :user, allow_nil: true, prefix: true
  delegate :age, to: :user, allow_nil: true, prefix: true
  delegate :city, to: :user, allow_nil: true, prefix: true
  delegate :state, to: :user, allow_nil: true, prefix: true
  delegate :biography, to: :user, allow_nil: true, prefix: true
  delegate :gender_str, to: :user, allow_nil: true, prefix: true
  delegate :simple_address, to: :user, allow_nil: true, prefix: true
  delegate :avatar, to: :user, allow_nil: true, prefix: true

  # Aliases
  alias_attribute :cover, :user_avatar

  def self.by_curriculum_function(curriculum_function_id)
    references(:curriculum_curriculum_functions)
      .where("curriculum_curriculum_functions.curriculum_function_id = ?",
             curriculum_function_id)
      .includes(:curriculum_curriculum_functions)
  end

  def self.by_age(age)
    start_age = begin
                  (age.split("-")[0]).to_i
                rescue StandardError
                  18
                end
    end_age = begin
                (age.split("-")[1]).to_i
              rescue StandardError
                99
              end
    references(:user).where("users.age >= ? AND users.age <= ?", start_age, end_age).includes(:user)
  end

  def self.by_gender(gender)
    references(:user).where("users.gender = ?", gender).includes(:user)
  end

  def self.by_state(state_id)
    references(:user).where("users.state_id = ?", state_id).includes(:user)
  end

  def self.by_city(city_id)
    references(:user).where("users.city_id = ?", city_id).includes(:user)
  end

  def self.by_ethnicity(ethnicity)
    where(ethnicity: ethnicity)
  end

  def self.by_drt(drt)
    where(drt: drt)
  end

  def self.by_mannequin(mannequin)
    where(mannequin: mannequin)
  end

  def self.by_mannequin(mannequin)
    start_mannequin = begin
                        (mannequin.split("-")[0]).to_i
                      rescue StandardError
                        34
                      end
    end_mannequin = begin
                      (mannequin.split("-")[1]).to_i
                    rescue StandardError
                      56
                    end
    references(:user).where("users.mannequin >= ? AND users.mannequin <= ?", start_mannequin, end_mannequin).includes(:user)
  end

  def self.by_height(height)
    height = height.to_i
    case height
    when 1
      where("height < 1.0")
    when 2
      where("height >= 1.01 AND height <= 1.20")
    when 3
      where("height >= 1.21 AND height <= 1.40")
    when 4
      where("height >= 1.41 AND height <= 1.60")
    when 5
      where("height >= 1.61 AND height <= 1.80")
    when 6
      where("height >= 1.81 AND height <= 2.0")
    when 7
      where("height > 2.0")
    else
      all
    end
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_curriculum_function(params[:curriculum_function_id]) unless params[:curriculum_function_id].blank?
    result = result.by_gender(params[:gender]) unless params[:gender].blank?
    result = result.by_state(params[:state_id]) unless params[:state_id].blank?
    result = result.by_city(params[:city_id]) unless params[:city_id].blank?
    result = result.by_ethnicity(params[:ethnicity]) unless params[:ethnicity].blank?
    result = result.by_drt(params[:drt]) unless params[:drt].blank?
    result = result.by_mannequin(params[:mannequin]) unless params[:mannequin].blank?
    result = result.by_age(params[:age]) unless params[:age].blank?
    result = result.by_height(params[:height]) unless params[:height].blank?
    result
  end

  def current_avatar
    return user_avatar.thumb unless user_avatar.url.blank?
  rescue StandardError
    "http://placehold.it/550x700"
  end

  def set_success(_format, _opts)
    self.success = true
  end

  def title_str
    return user_name if play_name.blank?
    play_name
  end

  def curriculum_functions_str
    curriculum_function_ids = curriculum_curriculum_functions.pluck(:curriculum_function_id)
    curriculum_functions = CurriculumFunction.where(id: curriculum_function_ids)
    return "" unless curriculum_functions
    curriculum_functions.pluck(:name).to_sentence
  end

  def age_str
    return "" if user_age.blank?
    "#{user_age} anos"
  end

  def original_title_str
    return user_name unless user_name == title_str
  end

  def biography_str
    return user_biography if biography.blank?
    biography
  end

  def drt_str
    return "Sim" if drt
    "Não"
  end

  def winnings_str
    [winnings1, winnings2, winnings3, winnings4, winnings5].reject(&:blank?).to_sentence
  end

  def jobs_str
    [jobs1, jobs2, jobs3, jobs4, jobs5].reject(&:blank?).to_sentence
  end

  def height_str
    return if height.blank?
    "#{height} m"
  end

  def mannequin_str
    return if mannequin.blank?
    mannequin
  end

  def ethnicity_str
    return "Branca" if white?
    return "Preta" if afrodescendant?
    return "Parda" if brown?
    return "Amarela" if yellow?
    return "Indígena" if indigenous?
    ""
  end

  def appearance_str
    [ethnicity_str, height_str, mannequin_str].reject(&:blank?).join(" / ")
  end
end
