# frozen_string_literal: true

class BroadcastsController < ApplicationController
  include BroadcastsBreadcrumb

  respond_to :html, :js

  PER_PAGE = 10

  # exposes
  expose(:broadcasts) { Broadcast.all_creation }
  expose(:broadcast, attributes: :broadcast_attributes)

  def index
    self.broadcasts = paginated_broadcasts
  end

  def show
    render layout: false
  end

  private

  def resource
    broadcast
  end

  def resource_title
    broadcast.title
  end

  def index_path
    broadcasts_path
  end

  def show_path
    broadcasts_path
  end

  def resource_params
    broadcast_params
  end

  def broadcast_params
    params.require(:broadcast).permit(PERMITTED_PARAMS)
  end

  # Filtering

  def paginated_broadcasts
    filtered_broadcast.page(params[:page]).per(PER_PAGE)
  end

  def filtered_broadcast
    broadcasts.filter_by(searched_broadcasts, params.fetch(:filter, ''))
  end

  def searched_broadcasts
    broadcasts.search(current_user, params.fetch(:search, ''))
  end
end
