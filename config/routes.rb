Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :clients, only: [:create, :index, :show] do
    resources :products, only: [:index, :show]
  end

  resources :products, only: [:create, :index, :show] do
    resources :clients, only: [:index, :show]
    resources :features, only: [:create, :index, :show]
  end

  resources :users
  resources :features, only: [:index, :show]
end
