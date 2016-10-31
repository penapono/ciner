Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  # admin: rotas de administração - ciner
  # platform: rotas da plataforma - público

  get "/seja_ciner", to: "plans#index", as: "plans"

end
