Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :clients, only: [:create, :index, :show] do
    resources :products, only: [:index, :show] do
      resources :roles, only: [:index, :show]
    end
  end

  resources :products, only: [:create, :index, :show] do
    resources :features, only: [:create, :index, :show]
    resources :clients, only: [:index, :show] do
      resources :roles, only: [:index, :show]
    end
  end

  resources :contracts, only: [:create]

  resources :users, only: [:index, :show, :create] do
    post '/roles/:role_id', to: 'users_role#create'
  end

  resources :features, only: [:index, :show] do
    post '/roles/:role_id', to: 'features_role#create'
  end

  resources :roles, only: [:index, :show, :create] do
    post '/users/:user_id', to: 'users_role#create'
    post '/features/:feature_id', to: 'features_role#create'
  end
end
