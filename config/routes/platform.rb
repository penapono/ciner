Rails.application.routes.draw do
  namespace :platform do
    root 'home#index'

    resources :users, only: [:update, :show, :edit] do
      resources :collection, only: :index, module: 'users'
      resources :trophies, only: :index, module: 'users'
      resources :favorite, only: :index, module: 'users'
      resources :watched, only: :index, module: 'users'
    end

    resources :studios, only: [:index, :show]
    resources :professionals, only: [:index, :show]
    resources :curriculums
    resources :notifications
    resources :featured_filmables, only: :index
    resources :playing_filmables, only: :index

    resources :movies, only: [:index, :show] do
      member do
        put "like", to: "movies#upvote"
        put "dislike", to: "movies#downvote"
        put "user_action", to: "movies#user_action"
      end
    end

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

    resources :series, only: [:index, :show] do
      member do
        put "like", to: "series#upvote"
        put "dislike", to: "series#downvote"
        put "user_action", to: "series#user_action"
      end
    end

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

    resources :questions do
      member do
        put "like", to: "questions#upvote"
        put "dislike", to: "questions#downvote"
      end
    end

    resources :broadcasts, only: :index do
      member do
        put "like", to: "broadcasts#upvote"
        put "dislike", to: "broadcasts#downvote"
      end
    end
  end
end
