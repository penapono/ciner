# frozen_string_literal: true

class Api::V1::UserFilmableRatingsController < ApplicationController
  def create
    user_filmable_rating =
      UserFilmableRating.find_or_initialize_by(
        filmable_type: user_filmable_rating_params[:filmable_type],
        filmable_id: user_filmable_rating_params[:filmable_id],
        user_id: user_filmable_rating_params[:user_id]
      )

    rating = begin
               user_filmable_rating_params[:rating].to_i
             rescue StandardError
               1
             end

    if user_filmable_rating.persisted? && user_filmable_rating.rating == rating
      user_rating = 0
      user_filmable_rating.destroy
    else
      user_filmable_rating.rating = user_filmable_rating_params[:rating]
      user_rating = user_filmable_rating.rating
      user_filmable_rating.save
    end

    current_rating = user_filmable_rating.filmable.users_rating
    render json: { status: "ok", current_rating: current_rating, user_rating: user_rating }
  end

  private

  def user_filmable_rating_params
    params.require(:user_filmable_rating).permit(:filmable_type, :filmable_id, :user_id, :rating)
  end
end
