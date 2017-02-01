Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'home#index'

  # admin: rotas de administração - ciner
  # platform: rotas da plataforma - público

  get "/seja_ciner", to: "plans#index", as: "plans"
  get "/movies", to: "movies#index", as: "movies"
  resources :critics, only: [:index, :show]
  get "/debates", to: "debates#index", as: "debates"
  get "/news", to: "news#index", as: "news"
  get "/newdetail", to: "news#detail", as: "newdetail"
  get "/cinervideos", to: "cinervideos#index", as: "cinervideos"
  get "/professionals", to: "professionals#index", as: "professionals"
  get "/criticdetail", to: "critics#detail", as: "criticdetail"

  namespace :api do
    namespace :v1 do
      resources :ceps, only: :index
      resources :cities, only: :index
      resources :countries, only: :index
      resources :users, only: :index
      resources :movies, only: :index
      resources :series, only: :index
    end
  end
end
