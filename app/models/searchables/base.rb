# frozen_string_literal: true

#
# Módulo usado por todos os models que fazem parte da busca geral.
#
# Leia mais em app/models/searchables/README.md
#
module Searchables
  module Base
    extend ActiveSupport::Concern

    DEFAULT_SEARCH_PARTIAL = 'result'

    included do
      def self.search_associations
        self::SEARCH_ASSOCIATIONS ||= [].freeze
      end

      def self.search(user, search_term, _limit = nil)
        search_for_model(self, user, search_term, limit = nil)
      end

      def self.search_expression
        self::SEARCH_EXPRESSION
      end

      def self.search_scope(_user)
        all.search_joins
      end

      def url_helper
        Rails.application.routes.url_helpers
      end

      private

      def self.search_joins
        includes(search_associations).references(search_associations)
      end

      def self.search_for_model(model, user, search_term, limit = nil)
        return model.search_scope(user) unless search_term

        search = prepare_search_term(search_term)
        results = model.search_scope(user).where(search_expression, search: search)

        return results.limit(limit) if limit

        results
      end

      def self.prepare_search_term(search_term)
        search_term = check_for_date_param(search_term)
        '%' + search_term.tr(' ', '%') + '%'
      end

      def self.check_for_date_param(search_term)
        has_date = search_term.match(%r{\d{2}/\d{2}/\d{4}}).present?
        search_term = search_term.split('/').reverse.join('-') if has_date
        search_term
      end
    end

    def search_partial
      DEFAULT_SEARCH_PARTIAL
    end
  end
end
