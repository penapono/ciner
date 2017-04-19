Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    resources :users
    resources :set_functions
    resources :studios
    resources :professionals
    resources :age_ranges
    resources :film_production_categories
    resources :movies
    match 'movies/bulk_destroy' => 'movies#bulk_destroy', via: :post

    resources :series
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
  end
end
