Rails.application.routes.draw do
  namespace :platform do
    root 'home#index'

    resources :users, only: [:update]

    get '/profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'

    resources :studios, only: [:index, :show]
    resources :professionals, only: [:index, :show]
    resources :movies, only: [:index, :show]
    resources :series, only: [:index, :show]
    resources :ciner_videos, only: [:index, :show]
    resources :events

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
