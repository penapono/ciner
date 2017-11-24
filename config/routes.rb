Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'logo#index'

  match 'critics/query' => 'critics#query', via: :get
  match 'events/query' => 'events#query', via: :get
  match 'questions/query' => 'questions#query', via: :get
  match 'broadcasts/query' => 'broadcasts#query', via: :get
  match 'movies/query' => 'movies#query', via: :get
  match 'series/query' => 'series#query', via: :get
  match 'curriculums/query' => 'curriculums#query', via: :get
  match 'professionals/query' => 'professionals#query', via: :get
  match 'users/query' => 'users#query', via: :get

  devise_for :users, controllers: { registrations: 'registrations' }

  # admin: rotas de administração - ciner
  # platform: rotas da plataforma - público

  # get "/seja_ciner", to: "plans#index", as: "plans"
  # get "/movies", to: "movies#index", as: "movies"
  # get "/debates", to: "debates#index", as: "debates"
  # get "/news", to: "news#index", as: "news"
  # get "/newdetail", to: "news#detail", as: "newdetail"
  # get "/cinervideos", to: "cinervideos#index", as: "cinervideos"
  # get "/professionals", to: "professionals#index", as: "professionals"
  # get "/criticdetail", to: "critics#detail", as: "criticdetail"
  get '/home', to: 'home#index'
  get '/contract', to: 'contracts#index'
  get '/privacy', to: 'privacies#index'
  get '/mission', to: 'missions#index'
  get '/merchant', to: 'merchants#index'
  get '/contact', to: 'contacts#index'

  resources :critics, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :questions, only: [:index, :show]
  resources :broadcasts, only: [:index, :show]
  resources :featured_filmables, only: :index
  resources :notifications, except: [:show]
  resources :playing_filmables, only: :index
  resources :searches, only: :index

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
    resources :trophies, only: :index, module: 'users'
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
