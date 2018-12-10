# frozen_string_literal: true

module Visitable
  extend ActiveSupport::Concern

  included do
    def visits_count_str
      id = self.id
      visits = Visit.resource_count(current_model, id)
      return "+ 99999" if visits > 99_999

      visits
    end

    def visits_count
      id = self.id
      Visit.resource_count(current_model, id)
    end

    def current_model
      self.class.to_s.pluralize.downcase
    end
  end
end
