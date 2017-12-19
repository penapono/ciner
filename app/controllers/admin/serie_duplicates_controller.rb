# frozen_string_literal: true

module Admin
  class SerieDuplicatesController < AdminController
    PER_PAGE = 100

    # exposes
    expose(:serie_duplicates) { SerieDuplicate.order(created_at: :desc) }

    def index
      self.serie_duplicates = paginated_serie_duplicates
    end

    private

    def paginated_serie_duplicates
      serie_duplicates.page(params[:page]).per(PER_PAGE)
    end
  end
end
