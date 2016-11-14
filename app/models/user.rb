class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Avatar Uploader
  mount_uploader :avatar, UserAvatarUploader

  # Associations
  belongs_to :city

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
            :password_confirmation,
            presence: true

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

  def age
    return 0 unless birthday
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def self.localized_roles
    roles.map { |k, w| [human_attribute_name("role.#{k}"), k]}
  end

  def self.localized_genders
    genders.map { |k, w| [human_attribute_name("gender.#{k}"), k]}
  end
end
