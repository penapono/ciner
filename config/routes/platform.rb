Rails.application.routes.draw do
  namespace :platform do
    resources :users, only: [:update]
    get '/profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'

    root 'users#show'

    resources :set_functions, only: [:index, :show]
    resources :studios, only: [:index, :show]
    resources :professionals, only: [:index, :show]
    resources :age_ranges, only: [:index, :show]
    resources :film_production_categories, only: [:index, :show]
    resources :film_productions, only: [:index, :show]
  end
end
