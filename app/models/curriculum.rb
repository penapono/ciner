# frozen_string_literal: true

class Curriculum < ActiveRecord::Base
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
    return "Altura não informada" if height.blank?
    "Altura: #{height}"
  end

  def mannequin_str
    return "Manequim não informado" if mannequin.blank?
    "Manequim: #{mannequin}"
  end

  def ethnicity_str
    return "Raça: Branca" if white?
    return "Raça: Preta" if afrodescendant?
    return "Raça: Parda" if brown?
    return "Raça: Amarela" if yellow?
    return "Raça: Indígena" if indigenous?
    "Raça não informada"
  end

  def appearance_str
    [ethnicity_str, height_str, mannequin_str].reject(&:blank?).join(" / ")
  end
end
