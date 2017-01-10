Rails.application.routes.draw do
  namespace :platform do
    resources :users, only: [:update]
    get '/profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'

    root 'users#show'

    resources :studios, only: [:index, :show]
    resources :professionals, only: [:index, :show]
    resources :movies, only: [:index, :show]
    resources :series, only: [:index, :show]
    resources :ciner_videos, only: [:index, :show]
    resources :critics, only: [:index, :show]
  end
end
