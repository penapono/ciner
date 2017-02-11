# frozen_string_literal: true
module Visitable
  extend ActiveSupport::Concern

  included do
    def visits_count_str
      12
    end
  end
end
