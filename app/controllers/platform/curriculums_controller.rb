# frozen_string_literal: true

module Platform
  class CurriculumsController < PlatformController
    include Platform::CurriculumsBreadcrumb

    # exposes
    expose(:curriculums) { Curriculum.all }
    expose(:curriculum, attributes: :curriculum_attributes)
    PER_PAGE = 50

    def index
      return if curriculums.blank?
      self.curriculums = paginated_curriculums
    end

    def create
      if created?
        redirect_to_show_with_success
      else
        render_new_with_error
      end
    end

    def destroy
      user = resource.user
      destroyed?
      redirect_to url_for([:platform, user])
    end

    private

    # Filtering

    def paginated_curriculums
      filtered_curriculum.page(params[:page]).per(PER_PAGE)
    end

    def filtered_curriculum
      curriculums.filter_by(searched_curriculums, params.fetch(:filter, ''))
    end

    def searched_curriculums
      curriculums.search(nil, params.fetch(:search, ''))
    end

    def resource
      curriculum
    end

    def resource_title
      curriculum.user_name
    end

    def index_path
      platform_curriculums_path
    end

    def show_path
      platform_curriculum_path(resource)
    end

    def resource_params
      curriculum_params
    end

    def curriculum_params
      params.require(:curriculum).permit(
        :play_name,
        :avatar,
        :biography,
        :user_id,
        :user,
        # Measures
        :mannequin,
        :height,
        :ethnicity,
        :drt,
        :jobs,
        :awards,
        curriculum_photos_attributes: %i[
          media
          curriculum_id
          id
          _destroy
        ],
        curriculum_audios_attributes: %i[
          media
          curriculum_id
          id
          _destroy
        ],
        curriculum_videos_attributes: %i[
          media
          curriculum_id
          id
          _destroy
        ],
        curriculum_files_attributes: %i[
          media
          curriculum_id
          id
          _destroy
        ],
        curriculum_curriculum_functions_attributes: %i[
          curriculum_function_id
          curriculum_id
          id
          _destroy
        ]
      )
    end
  end
end
