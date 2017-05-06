Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'

  # admin: rotas de administração - ciner
  # platform: rotas da plataforma - público

  get "/seja_ciner", to: "plans#index", as: "plans"
  get "/movies", to: "movies#index", as: "movies"
  get "/debates", to: "debates#index", as: "debates"
  get "/news", to: "news#index", as: "news"
  get "/newdetail", to: "news#detail", as: "newdetail"
  get "/cinervideos", to: "cinervideos#index", as: "cinervideos"
  get "/professionals", to: "professionals#index", as: "professionals"
  get "/criticdetail", to: "critics#detail", as: "criticdetail"

  resources :critics, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :questions, only: [:index, :show]
  resources :broadcasts, only: [:index, :show]

  resources :movies, only: [:index, :show] do
    member do
      put "like", to: "movies#upvote"
      put "dislike", to: "movies#downvote"
      put "user_action", to: "movies#user_action"
    end
  end

  resources :series, only: [:index, :show] do
    member do
      put "like", to: "series#upvote"
      put "dislike", to: "series#downvote"
      put "user_action", to: "series#user_action"
    end
  end

  resources :professionals, only: [:index, :show]
  resources :curriculums, only: [:index, :show]
  resources :users do
    resources :collection, only: :index, module: 'users'
    resources :favorite, only: :index, module: 'users'
    resources :watched, only: :index, module: 'users'
  end

  resources :user_filmables

  namespace :api do
    namespace :v1 do
      resources :ceps, only: :index
      resources :cities, only: :index
      resources :countries, only: :index
      resources :users, only: :index
      resources :movies, only: :index
      resources :series, only: :index
      resources :professionals, only: :index
      resources :comments do
        member do
          put "like", to: "comments#upvote"
          put "dislike", to: "comments#downvote"
        end
      end
      resources :visits, only: :create
    end
  end
end
