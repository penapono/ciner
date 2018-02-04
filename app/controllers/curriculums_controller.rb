# frozen_string_literal: true

class CurriculumsController < ApplicationController
  include CurriculumsBreadcrumb
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
    destroyed?
    redirect_to url_for([:platform, "profile"])
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
    curriculums_path
  end

  def show_path
    curriculum_path(resource)
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
      :set_function,
      # If Professional is an User
      :user,
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
