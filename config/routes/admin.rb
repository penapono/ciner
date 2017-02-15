Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    resources :users
    resources :set_functions
    resources :studios
    resources :professionals
    resources :age_ranges
    resources :film_production_categories
    resources :film_productions
    resources :movies
    resources :series
    resources :ciner_videos
    resources :ciner_news
    resources :events

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
