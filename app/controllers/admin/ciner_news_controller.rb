# frozen_string_literal: true
module Admin
  class CinerNewsController < AdminController
    include Admin::CinerNewsBreadcrumb

    # exposes
    expose(:ciner_news) { CinerNew.all }
    expose(:ciner_new, attributes: :ciner_new_attributes)
    expose(:countries) { Country.all }
    expose(:states) { State.all }
    expose(:cities) { City.all }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.ciner_news = paginated_ciner_news
    end

    private

    def resource
      ciner_new
    end

    def resource_title
      ciner_new.name
    end

    def index_path
      admin_ciner_news_index_path
    end

    def show_path
      admin_ciner_news_path(resource)
    end

    def resource_params
      ciner_new_params
    end

    def ciner_new_params
      params.require(:ciner_new).permit(
        :name, :country_id, :state_id, :city_id
      )
    end

    # Filtering

    def paginated_ciner_news
      filtered_ciner_new.page(params[:page]).per(PER_PAGE)
    end

    def filtered_ciner_new
      ciner_news.filter_by(searched_ciner_news, params.fetch(:filter, ''))
    end

    def searched_ciner_news
      ciner_news.search(current_user, params.fetch(:search, ''))
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
