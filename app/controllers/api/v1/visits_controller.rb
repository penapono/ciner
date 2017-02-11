# frozen_string_literal: true
class Api::V1::VisitsController < ApplicationController
  expose (:visit) { Visit.new(visit_params) }

  def create
    render json: { status: (visit.save ? "ok" : "error") }
  end

  private

  def visit_params
    params.require(:visit).permit(:controller, :action, :resource_id, :path, :user_id)
  end
end
