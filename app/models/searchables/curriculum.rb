# frozen_string_literal: true

module Searchables
  module Curriculum
    extend ActiveSupport::Concern
    include Searchables::Base

    SEARCH_EXPRESSION = '
      curriculums.play_name LIKE :search OR
      curriculums.awards LIKE :search OR
      curriculums.jobs LIKE :search OR
      curriculums.biography LIKE :search OR
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
      users.biography LIKE :search
    '

    SEARCH_ASSOCIATIONS = [
      :user
    ].freeze

    class_methods do
      def search_associations
        self::SEARCH_ASSOCIATIONS
      end
    end

    def search_link
      url_helper.admin_curriculums_path(curriculum: id)
    end

    def search_title
      play_name
    end

    def search_description
      play_name
    end
  end
end
