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

  validates_uniqueness_of :email

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
end
