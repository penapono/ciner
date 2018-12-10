# frozen_string_literal: true

class Api::V1::MoviesController < ApplicationController
  include Api::V1::BaseController

  LIMIT = 15

  def index
    render json: resources.to_json(only: :id, methods: :text)
  end

  private

  def fetch_term
    return params[:search].fetch(:term, '') unless params[:search].blank?

    params.fetch(:term, '')
  end

  def resources
    Movie.where(original_title: fetch_term).limit(LIMIT) + Movie.where(title: fetch_term).limit(LIMIT)
  end
end
