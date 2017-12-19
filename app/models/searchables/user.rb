# frozen_string_literal: true

module Searchables
  module User
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      users.name LIKE :search OR
      users.email LIKE :search OR
      users.nickname LIKE :search OR
      users.cep LIKE :search OR
      users.address LIKE :search OR
      users.number LIKE :search OR
      users.neighbourhood LIKE :search OR
      users.complement LIKE :search OR
      users.cpf LIKE :search OR
      users.phone LIKE :search OR
      users.mobile LIKE :search OR
      users.biography LIKE :search OR
      cities.name LIKE :search OR
      states.name LIKE :search OR
      countries.name LIKE :search
    '

    SEARCH_ASSOCIATIONS = %i[
      city state country
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_users_path(user: id)
    end

    def search_title
      name
    end

    def search_description
      biography
    end
  end
end
