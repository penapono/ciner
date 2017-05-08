# frozen_string_literal: true

class Curriculum < ActiveRecord::Base
  include Searchables::Curriculum

  # Associations
  belongs_to :user
  belongs_to :set_function

  # Validations
  validates :user_id,
            :set_function_id,
            :play_name,
            presence: true

  # gender
  # 0: Men, 1: Women, 2: Other
  enum gender: { men: 0, women: 1, other: 2 }
  enum ethnicity: { white: 1, afrodescendant: 2, brown: 3, yellow: 4, indigenous: 5 }

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :age, to: :user, allow_nil: true, prefix: true
  delegate :city, to: :user, allow_nil: true, prefix: true
  delegate :state, to: :user, allow_nil: true, prefix: true
  delegate :biography, to: :user, allow_nil: true, prefix: true
  delegate :gender_str, to: :user, allow_nil: true, prefix: true
  delegate :simple_address, to: :user, allow_nil: true, prefix: true
  delegate :avatar, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :set_function, allow_nil: true, prefix: true

  # Uploaders
  mount_uploader :avatar, CurriculumAvatarUploader
  mount_uploader :photo1, CurriculumAvatarUploader
  mount_uploader :photo2, CurriculumAvatarUploader
  mount_uploader :photo3, CurriculumAvatarUploader
  mount_uploader :photo4, CurriculumAvatarUploader
  mount_uploader :photo5, CurriculumAvatarUploader
  mount_uploader :photo6, CurriculumAvatarUploader
  mount_uploader :photo7, CurriculumAvatarUploader
  mount_uploader :photo8, CurriculumAvatarUploader
  mount_uploader :photo9, CurriculumAvatarUploader
  mount_uploader :photo10, CurriculumAvatarUploader

  mount_uploader :file1, CurriculumFileUploader
  mount_uploader :file2, CurriculumFileUploader
  mount_uploader :file3, CurriculumFileUploader

  mount_uploader :video1, CurriculumVideoUploader
  mount_uploader :video2, CurriculumVideoUploader
  mount_uploader :video3, CurriculumVideoUploader

  mount_uploader :audio1, CurriculumAudioUploader
  mount_uploader :audio2, CurriculumAudioUploader
  mount_uploader :audio3, CurriculumAudioUploader

  # Filters
  # filter[set_function_id]=1&
  # filter[age]=22&
  # filter[gender]=men&
  # filter[state_id]=27&
  # filter[state_id]=8&
  # filter[ethnicity]=white&
  # filter[drt]=true&
  # filter[mannequin]=

  def self.by_set_function(set_function_id)
    where(set_function: set_function_id)
  end

  def self.by_age(age)
    references(:user).where("users.age = ?", age).includes(:user)
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

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_set_function(params[:set_function_id]) unless params[:set_function_id].blank?
    result = result.by_age(params[:age]) unless params[:age].blank?
    result = result.by_gender(params[:gender]) unless params[:gender].blank?
    result = result.by_state(params[:state_id]) unless params[:state_id].blank?
    result = result.by_city(params[:city_id]) unless params[:city_id].blank?
    result = result.by_ethnicity(params[:ethnicity]) unless params[:ethnicity].blank?
    result = result.by_drt(params[:drt]) unless params[:drt].blank?
    result = result.by_mannequin(params[:mannequin]) unless params[:mannequin].blank?
    result
  end

  def current_avatar
    return avatar unless avatar.url.blank?
    return user_avatar unless user_avatar.url.blank?
    "http://placehold.it/550x700"
  end

  def set_success(_format, _opts)
    self.success = true
  end

  def title_str
    return user_name if play_name.blank?
    play_name
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
    return "-" if height.blank?
    "#{height} m"
  end

  def mannequin_str
    return "-" if mannequin.blank?
    mannequin
  end

  def ethnicity_str
    return "Branca" if white?
    return "Preta" if afrodescendant?
    return "Parda" if brown?
    return "Amarela" if yellow?
    return "Indígena" if indigenous?
    "-"
  end

  def appearance_str
    [ethnicity_str, height_str, mannequin_str].reject(&:blank?).join(" / ")
  end
end
