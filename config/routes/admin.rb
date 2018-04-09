Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    match 'critics/query' => 'critics#query', via: :get
    match 'events/query' => 'events#query', via: :get
    match 'questions/query' => 'questions#query', via: :get
    match 'broadcasts/query' => 'broadcasts#query', via: :get
    match 'movies/query' => 'movies#query', via: :get
    match 'series/query' => 'series#query', via: :get
    match 'curriculums/query' => 'curriculums#query', via: :get
    match 'professionals/query' => 'professionals#query', via: :get
    match 'users/query' => 'users#query', via: :get

    resources :users do
      resources :collection, only: :index, module: 'users'
      resources :trophies, only: :index, module: 'users'
      resources :favorite, only: :index, module: 'users'
      resources :watched, only: :index, module: 'users'
      resources :want_to_see, only: :index, module: 'users'
    end

    resources :set_functions
    resources :curriculum_functions
    resources :studios
    resources :professionals
    resources :duplicate_professionals
    resources :curriculums
    resources :notifications
    resources :age_ranges
    resources :trending_trailers
    resources :film_production_categories
    resources :featured_filmables, only: :index
    resources :playing_filmables, only: :index
    resources :delates
    resources :movie_duplicates, only: :index
    resources :serie_duplicates, only: :index

    match "movies/playing", to: "movies#playing", via: :get
    match "movies/featured", to: "movies#featured", via: :get
    match "movies/playing_soon", to: "movies#playing_soon", via: :get
    match "movies/available_netflix", to: "movies#available_netflix", via: :get
    match 'movies/bulk_destroy' => 'movies#bulk_destroy', via: :post
    resources :movies do
      member do
        put "like", to: "movies#upvote"
        put "dislike", to: "movies#downvote"
        put "user_action", to: "movies#user_action"
      end
    end

    match "series/playing", to: "series#playing", via: :get
    match "series/featured", to: "series#featured", via: :get
    match "series/playing_soon", to: "series#playing_soon", via: :get
    match "series/available_netflix", to: "series#available_netflix", via: :get
    match 'series/bulk_destroy' => 'series#bulk_destroy', via: :post
    resources :series do
      member do
        put "like", to: "series#upvote"
        put "dislike", to: "series#downvote"
        put "user_action", to: "series#user_action"
      end
    end

    match "ciner_productions/all", to: "ciner_productions#all", via: :get
    resources :ciner_productions do
      member do
        put "like", to: "ciner_productions#upvote"
        put "dislike", to: "ciner_productions#downvote"
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
