Rails.application.routes.draw do
  namespace :platform do
    root 'home#index'

    resources :users, only: [:update] do
      resources :collection, only: :index, module: 'users'
      resources :favorite, only: :index, module: 'users'
      resources :watched, only: :index, module: 'users'
    end

    get '/profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'

    resources :studios, only: [:index, :show]
    resources :professionals, only: [:index, :show]
    resources :curriculums
    resources :featured_filmables, only: :index
    resources :playing_filmables, only: :index

    resources :movies, only: [:index, :show] do
      member do
        put "like", to: "movies#upvote"
        put "dislike", to: "movies#downvote"
        put "user_action", to: "movies#user_action"
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

    resources :broadcasts do
      member do
        put "like", to: "broadcasts#upvote"
        put "dislike", to: "broadcasts#downvote"
      end
    end
  end
end
