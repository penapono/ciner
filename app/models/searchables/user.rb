module Searchables::User
  extend ActiveSupport::Concern
  include Searchables::Base

  SEARCH_EXPRESSION = %q{
    users.name LIKE :search OR
    users.nickname LIKE :search OR
    users.email LIKE :search OR
    cities.name LIKE :search
  }

  SEARCH_ASSOCIATIONS = [
    :city, :state
  ]

  class_methods do
    def search_associations
      self::SEARCH_ASSOCIATIONS
    end
  end

  included do
    private

    def self.search_scope(user)
      User.search_joins
    end
  end

  def search_link
    url_helper.platform_users_path(user: id)
  end

  def search_title
    name
  end

  def search_description
    name
  end
end
