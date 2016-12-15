Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    resources :users
    resources :set_functions
    resources :studios
    resources :professionals
    resources :age_ranges
    resources :film_production_categories
  end
end
