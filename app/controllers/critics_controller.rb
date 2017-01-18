# frozen_string_literal: true
class CriticsController < ApplicationController
  # exposes
  expose(:critics) { Critic.all }
  expose(:critic, attributes: :critic_attributes)

  def index
  end

  def show
  end
end
