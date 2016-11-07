Rails.application.routes.draw do
  namespace :admin do
    root 'users#index'

    resources :users
    resources :set_functions
  end
end
