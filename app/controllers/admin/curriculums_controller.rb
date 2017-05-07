# frozen_string_literal: true

module Admin
  class CurriculumsController < AdminController
    include Admin::CurriculumsBreadcrumb

    # exposes
    expose(:curriculums) { Curriculum.all }
    expose(:curriculum, attributes: :curriculum_attributes)

    def create
      if created?
        redirect_to_show_with_success
      else
        render_new_with_error
      end
    end

    def destroy
      destroyed?
      redirect_to url_for([:admin, "profile"])
    end

    private

    def resource
      curriculum
    end

    def resource_title
      curriculum.user_name
    end

    def index_path
      admin_curriculums_path
    end

    def show_path
      admin_curriculum_path(resource)
    end

    def resource_params
      curriculum_params
    end

    def curriculum_params
      params.require(:curriculum).permit(
        :play_name,
        :avatar,
        :biography,

        # Professional Attributes
        :set_function_id,

        # If Professional is an User
        :user_id,

        # Measures
        :mannequin,
        :height,
        :ethnicity,

        :drt,
        :winnings1,
        :winnings2,
        :winnings3,
        :winnings4,
        :winnings5,
        :jobs1,
        :jobs2,
        :jobs3,
        :jobs4,
        :jobs5,
        :photo1,
        :photo2,
        :photo3,
        :photo4,
        :photo5,
        :photo6,
        :photo7,
        :photo8,
        :photo9,
        :photo10,
        :video1,
        :video2,
        :video3,
        :audio1,
        :audio2,
        :audio3,
        :file1,
        :file2,
        :file3
      )
    end
  end
end
