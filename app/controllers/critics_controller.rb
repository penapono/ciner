# frozen_string_literal: true
class CriticsController < ApplicationController
  # exposes
  expose(:critics) { Critic.all }
  expose(:critic, attributes: :critic_attributes)
  expose(:users) { User.all }

  PER_PAGE = 10

  def index
    self.critics = paginated_critics
  end

  private

  def resource
    critic
  end

  def resource_title
    critic.name
  end

  def index_path
    admin_critics_path
  end

  def show_path
    admin_critic_path(resource)
  end

  def resource_params
    critic_params
  end

  # Filtering

  def paginated_critics
    filtered_critic.page(params[:page]).per(PER_PAGE)
  end

  def filtered_critic
    critics.filter_by(searched_critics, params.fetch(:filter, ''))
  end

  def searched_critics
    critics.search(nil, params.fetch(:search, ''))
  end
end
