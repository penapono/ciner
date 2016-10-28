Rails.application.routes.draw do
  namespace :platform do
    resources :users, only: [:update]
    get '/profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'

    root 'users#show'
  end
end
