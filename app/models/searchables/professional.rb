# frozen_string_literal: true

module Searchables
  module Professional
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      professionals.name LIKE :search OR
      professionals.nickname LIKE :search OR
      professionals.cep LIKE :search OR
      professionals.neighbourhood LIKE :search OR
      professionals.complement LIKE :search OR
      professionals.cpf LIKE :search OR
      professionals.phone LIKE :search OR
      professionals.mobile LIKE :search OR
      professionals.biography LIKE :search OR
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
      url_helper.admin_professionals_path(professional: id)
    end

    def search_title
      name
    end

    def search_description
      biography
    end
  end
end
