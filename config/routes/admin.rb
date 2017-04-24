Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    get '/profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'

    resources :users do
      resources :collection, only: :index, module: 'users'
      resources :favorite, only: :index, module: 'users'
      resources :watched, only: :index, module: 'users'
    end

    resources :set_functions
    resources :studios
    resources :professionals
    resources :age_ranges
    resources :film_production_categories

    resources :movies do
      member do
        put "like", to: "movies#upvote"
        put "dislike", to: "movies#downvote"
        put "user_action", to: "movies#user_action"
      end
    end
    match 'movies/bulk_destroy' => 'movies#bulk_destroy', via: :post

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
