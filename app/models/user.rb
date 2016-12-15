class User < ActiveRecord::Base
  include Searchables::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Avatar Uploader
  mount_uploader :avatar, UserAvatarUploader

  # Associations
  belongs_to :city
  belongs_to :state

  # Validations
  validates :email,
            :name,
            :birthday,
            :cpf,
            :cep,
            :address,
            :number,
            :neighbourhood,
            :state_id,
            :city_id,
            :gender,
            :role,
            :nickname,
            :terms_of_use,
            presence: true

  validates_presence_of :password_confirmation, on: :create

  # Enums

  # role
  # 0: Admin
  # 1: Ciner Free / 2: Ciner Pro / 3: Ciner Clássico / 4: Ciner Cult
  enum role: { admin: 0, free: 1, pro: 2, classic: 3, cult: 4 }

  # gender
  # 0: Men, 1: Women, 2: Other
  enum gender: { men: 0, women: 1, other: 2 }

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true

  def age
    return 0 unless birthday
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def self.localized_roles
    roles.map { |k, w| [human_attribute_name("role.#{k}"), k]}
  end

  def self.localized_genders
    genders.map { |k, w| [human_attribute_name("gender.#{k}"), k]}
  end

  def registered_at_str
    return "Não informado" unless registered_at
    I18n.localize(registered_at)
  end

  def gender_str
    return "Não informado" unless gender
    User.human_attribute_name("gender.#{gender}")
  end

  def role_str
    return "Não informado" unless role
    User.human_attribute_name("role.#{role}")
  end
end
