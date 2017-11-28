# frozen_string_literal: true

class DelatesController < ApplicationController
  PERMITTED_PARAMS = %i[
    location
    user_id
  ].freeze

  expose(:delate, attributes: :delate_attributes)

  def create
    delate = Delate.new(delate_attributes)
    if delate.save
      render_json_success
    else
      render_json_error
    end
  end

  private

  def resource
    delate
  end

  def resource_title
    delate.location
  end

  def resource_params
    params.require(:delate).permit(PERMITTED_PARAMS)
  end

  def delate_attributes
    params.require(:delate).permit(:location, :user_id)
  end
end
