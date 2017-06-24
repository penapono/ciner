# frozen_string_literal: true

module Admin
  class CinerVideosController < AdminController
    include Admin::CinerVideosBreadcrumb

    # exposes
    expose(:ciner_videos) { CinerVideo.all }
    expose(:ciner_video, attributes: :ciner_video_attributes)

    expose(:age_ranges) { AgeRange.all }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 50

    def index
      self.ciner_videos = paginated_ciner_videos
    end

    def create
      if created?
        redirect_to upload_trailer_admin_ciner_video_path(resource)
      else
        render_new_with_error
      end
    end

    def upload_video; end

    def upload_trailer; end

    def update
      respond_to do |format|
        format.json do
          if updated?
            if !params[:ciner_video].blank? && !params[:ciner_video][:trailer].blank?
              render json: { status: 'OK', to: upload_video_admin_ciner_video_path(resource) }
            end
            if !params[:ciner_video].blank? && !params[:ciner_video][:media].blank?
              render json: { status: 'OK', to: admin_ciner_video_path(resource) }
            end
          else
            render json: { status: 'error' }
          end
        end
        format.html do
          super
        end
      end
    end

    private

    def resource
      ciner_video
    end

    def resource_title
      ciner_video.title
    end

    def index_path
      admin_ciner_videos_path
    end

    def show_path
      admin_ciner_video_path(resource)
    end

    def ciner_video_params
      params.require(:ciner_video).permit(
        :original_title,
        :title,
        :year,
        :length,
        :synopsis,
        :release,
        :brazilian_release,
        :city_id,
        :state_id,
        :country_id,
        :age_range_id,
        :cover,
        :studio_id,
        :created_at,
        :updated_at,
        :ciner_video_directors,
        :ciner_video_writers,
        :ciner_video_actors,
        :ciner_video_genre,
        :ciner_video_rated,
        :ciner_video_id,
        :ciner_video_trailer,
        :trailer,
        :media,
        :tmdb_id,
        :playing,
        :user_id,
        :lock_updates,
        :countries,
        :media,
        ciner_video_users_attributes: %i[
          set_function_id
          user_id
          ciner_video_id
          id
          _destroy
        ]
      )
    end

    def resource_params
      ciner_video_params
    end

    # Filtering

    def paginated_ciner_videos
      filtered_ciner_video.page(params[:page]).per(PER_PAGE)
    end

    def filtered_ciner_video
      ciner_videos.filter_by(searched_ciner_videos, params.fetch(:filter, ''))
    end

    def searched_ciner_videos
      ciner_videos.search(current_user, params.fetch(:search, ''))
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
