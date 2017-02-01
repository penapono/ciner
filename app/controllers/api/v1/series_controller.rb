# frozen_string_literal: true
class Api::V1::SeriesController < ApplicationController
  include Api::V1::BaseController

  LIMIT = 15

  def index
    render json: resources.to_json(only: :id, methods: :text)
  end

  private

  def fetch_term
    params.fetch(:search, {}).fetch(:term, '')
  end

  def resources
    Serie.search(current_user, fetch_term).limit(LIMIT)
  end
end
