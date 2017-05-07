# frozen_string_literal: true

class Curriculum < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :set_function

  # Validations
  validates :user_id,
            :set_function_id,
            presence: true

  # gender
  # 0: Men, 1: Women, 2: Other
  enum gender: { men: 0, women: 1, other: 2 }
  enum ethnicity: { white: 1, afrodescendant: 2, brown: 3, yellow: 4, indigenous: 5 }

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :name, to: :set_function, allow_nil: true, prefix: true

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

  def set_success(_format, _opts)
    self.success = true
  end

  def title_str
    user.name
  end
end
