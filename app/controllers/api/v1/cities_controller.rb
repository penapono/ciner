# frozen_string_literal: true
class Api::V1::CitiesController < ApplicationController
  def index
    cities = City.by_state_acronym(params[:acronym])
    render json: cities
  end
end
