Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#index'

  # admin: rotas de administração - ciner
  # platform: rotas da plataforma - público

  get "/seja_ciner", to: "plans#index", as: "plans"

  namespace :api do
    namespace :v1 do
      resources :ceps, only: :index
      resources :cities, only: :index
    end
  end
end
