# frozen_string_literal: true

class User < ActiveRecord::Base
  include Searchables::User

  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Uploaders
  mount_uploader :avatar, UserAvatarUploader

  # Associations
  belongs_to :city
  belongs_to :state
  belongs_to :country

  has_many :critics
  has_one :curriculum

  # Validations
  validates :email,
            :name,
            :birthday,
            :cpf,
            :gender,
            :role,
            :nickname,
            :terms_of_use,
            presence: true

  validates :cep,
            :address,
            :number,
            :neighbourhood,
            :state_id,
            :city_id,
            presence: true, unless: :free?

  validates_uniqueness_of :nickname, :email, :cpf

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
  delegate :name, to: :country, allow_nil: true, prefix: true

  # Callbacks
  before_save :update_address
  before_save :update_age

  # Aliases
  alias_attribute :text, :name

  def self.localized_roles
    roles.map { |k, _w| [human_attribute_name("role.#{k}"), k] }
  end

  def self.localized_genders
    genders.map { |k, _w| [human_attribute_name("gender.#{k}"), k] }
  end

  def friends
    ids = []
    Notification.where(sender_id: id, notification_type: :friend_request, answer: :approved).pluck(:receiver_id).each do |friend_id|
      ids << friend_id
    end
    Notification.where(receiver_id: id, notification_type: :friend_request, answer: :approved).pluck(:sender_id).each do |friend_id|
      ids << friend_id
    end
    User.where(id: ids.uniq)
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

  def nickname_str
    return name if nickname.blank? && !admin?
    return "#{name} (CINER)" if nickname.blank? && admin?
    return "#{nickname} (CINER)" if admin?
    nickname
  end

  # Scopes

  def self.by_gender(gender)
    where(gender: gender)
  end

  def self.by_role(role)
    where(role: role)
  end

  def self.by_city(city)
    where(city: city)
  end

  def self.by_state(id)
    where(state_id: id)
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_gender(genders[params[:gender]]) if params[:gender].present?
    result = result.by_role(roles[params[:role]]) if params[:role].present?
    result = result.by_state(params[:state]) if params[:state].present?
    result = result.by_city(params[:city]) if params[:city].present?

    result
  end

  def user_collection
    UserFilmable.collection.where(user: self).order(position: :asc)
  end

  def user_favorite
    filmables = []

    UserFilmable.favorite.where(user: self).each do |user_filmable|
      filmables << user_filmable.filmable
    end

    filmables
  end

  def user_watched
    filmables = []

    UserFilmable.watched.where(user: self).each do |user_filmable|
      filmables << user_filmable.filmable
    end

    filmables
  end

  def simple_address
    return "" unless city || state
    return "#{city_name} - #{state_name}" if city && state
    return city_name if city
    state_name if state
  end

  def trophy_count
    1
  end

  private

  def update_address
    return unless city
    self.state_id = city.state.id
    self.country_id = state.country.id
  end

  def update_age
    self.age = 0 unless birthday
    now = Time.now.utc.to_date
    self.age = now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end
end
