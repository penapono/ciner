Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    resources :users do
      resources :collection, only: :index, module: 'users'
      resources :favorite, only: :index, module: 'users'
      resources :watched, only: :index, module: 'users'
    end

    resources :set_functions
    resources :curriculum_functions
    resources :studios
    resources :professionals
    resources :curriculums
    resources :notifications
    resources :age_ranges
    resources :trending_trailers
    resources :film_production_categories
    resources :featured_filmables, only: :index
    resources :playing_filmables, only: :index

    resources :movies do
      member do
        put "like", to: "movies#upvote"
        put "dislike", to: "movies#downvote"
        put "user_action", to: "movies#user_action"
      end
    end
    match 'movies/bulk_destroy' => 'movies#bulk_destroy', via: :post

    resources :ciner_videos do
      member do
        put 'change_status', to: 'ciner_videos#change_status'
        get 'upload_video', to: 'ciner_videos#upload_video'
        get 'upload_trailer', to: 'ciner_videos#upload_trailer'
        put "like", to: "ciner_videos#upvote"
        put "dislike", to: "ciner_videos#downvote"
        put "user_action", to: "ciner_videos#user_action"
      end
    end

    resources :series do
      member do
        put "like", to: "series#upvote"
        put "dislike", to: "series#downvote"
        put "user_action", to: "series#user_action"
      end
    end
    match 'series/bulk_destroy' => 'series#bulk_destroy', via: :post

    resources :events do
      member do
        put "like", to: "events#upvote"
        put "dislike", to: "events#downvote"
      end
    end

    resources :critics do
      member do
        put "like", to: "critics#upvote"
        put "dislike", to: "critics#downvote"
      end
    end

    resources :broadcasts do
      member do
        put "like", to: "broadcasts#upvote"
        put "dislike", to: "broadcasts#downvote"
      end
    end

    resources :questions do
      member do
        put "like", to: "questions#upvote"
        put "dislike", to: "questions#downvote"
      end
    end

    get "settings", to: "settings#index", as: "settings"
  end
end
