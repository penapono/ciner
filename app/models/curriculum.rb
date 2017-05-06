# frozen_string_literal: true

class Curriculum < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :set_function

  # Validations
  validates :name,
            :set_function,
            presence: true

  # gender
  # 0: Men, 1: Women, 2: Other
  enum gender: { men: 0, women: 1, other: 2 }

  # Delegations
  delegate :name, to: :set_function, allow_nil: true, prefix: true

  # Callbacks
  before_save :update_age

  # Aliases
  alias_attribute :title_str, :name
  alias_attribute :text, :title_str

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

  def set_success(format, opts)
    self.success = true
  end

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

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_gender(genders[params[:gender]]) if params[:gender].present?

    result
  end

  def update_age
    self.age = 0
    return unless birthday
    now = Time.now.utc.to_date
    self.age = now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end
end
