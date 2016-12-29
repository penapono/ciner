Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#index'

  # admin: rotas de administração - ciner
  # platform: rotas da plataforma - público

  get "/seja_ciner", to: "plans#index", as: "plans"
  get "/movies", to: "movies#index", as: "movies"
  get "/critics", to: "critics#index", as: "critics"
  get "/debates", to: "debates#index", as: "debates"
  get "/news", to: "news#index", as: "news"
  get "/cinervideos", to: "cinervideos#index", as: "cinervideos"

  namespace :api do
    namespace :v1 do
      resources :ceps, only: :index
      resources :cities, only: :index
    end
  end
end
