class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  belongs_to :city

  # Validations
  validates :email,
            :name,
            :age,
            :birthday,
            :role,
            :city,
            presence: true

  # role
  # 0: Admin
  # 1: Ciner Free / 2: Ciner Pro / 3: Ciner Clássico / 4: Ciner Cult

  # Enums
  enum role: { admin: 0, free: 1, pro: 2, classic: 3, cult: 4 }

  validates_uniqueness_of :email

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
end
