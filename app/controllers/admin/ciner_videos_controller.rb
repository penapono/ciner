# frozen_string_literal: true
module Admin
  class CinerVideosController < AdminController
    include Admin::CinerVideosBreadcrumb

    # exposes
    expose(:ciner_videos) { CinerVideo.all }
    expose(:ciner_video, attributes: :ciner_video_attributes)

    expose(:countries) { Country.all }
    expose(:age_ranges) { AgeRange.all }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.ciner_videos = paginated_ciner_videos
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
        :country_id,
        :age_range_id,

        :cover,

        # Movie / Serie / CinerVideo

        :type,

        # Movie

        :studio,

        # Ciner Movie

        :approval,
        :approver,
        :owner,

        # Serie

        :season,
        :number_episodes,
        :aired_episodes
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
