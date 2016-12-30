# frozen_string_literal: true
module Admin
  class NewsController < AdminController
    include Admin::NewsBreadcrumb

    # exposes
    expose(:news) { New.all }
    expose(:new, attributes: :new_attributes)
    expose(:countries) { Country.all }
    expose(:states) { State.all }
    expose(:cities) { City.all }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.news = paginated_news
    end

    private

    def resource
      new
    end

    def resource_title
      new.name
    end

    def index_path
      admin_news_path
    end

    def show_path
      admin_new_path(resource)
    end

    def resource_params
      new_params
    end

    def new_params
      params.require(:new).permit(
        :name, :country_id, :state_id, :city_id
      )
    end

    # Filtering

    def paginated_news
      filtered_new.page(params[:page]).per(PER_PAGE)
    end

    def filtered_new
      news.filter_by(searched_news, params.fetch(:filter, ''))
    end

    def searched_news
      news.search(current_user, params.fetch(:search, ''))
    end

    # Filters

    def filtered_states
      return unless params[:filter] && params[:filter][:country].present?
      Country.find(params[:filter][:country]).states
    end

    def filtered_cities
      return unless params[:filter] && params[:filter][:state].present?
      State.find(params[:filter][:state]).cities
    end
  end
end
