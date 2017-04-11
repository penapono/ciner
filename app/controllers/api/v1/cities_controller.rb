# frozen_string_literal: true

module Api
  module V1
    class CitiesController < ApplicationController
      def index
        cities = City.by_state_acronym(params[:acronym])
        render json: cities
      end
    end
  end
end
