Rails.application.routes.draw do
  namespace :admin do
    root 'home#index'

    resources :users
    resources :set_functions
  end
end
