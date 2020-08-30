Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :clients, only: [:create, :index, :show, :update] do
    resources :products, only: [:index, :show] do
      resources :roles, only: [:index, :show, :destroy]
    end
  end

  resources :products, only: [:create, :index, :show, :update] do
    resources :features, only: [:create, :index, :show, :destroy]
    resources :clients, only: [:index, :show] do
      resources :roles, only: [:index, :show, :destroy]
    end
  end

  resources :contracts, only: [:create]

  resources :users, only: [:index, :show, :create, :destroy, :update] do
    post '/roles/:role_id', to: 'users_role#create'
    delete '/roles/:role_id', to: 'users_role#destroy'
  end

  resources :features, only: [:index, :show, :destroy, :update] do
    post '/roles/:role_id', to: 'features_role#create'
    delete '/roles/:role_id', to: 'features_role#destroy'
  end

  resources :roles, only: [:index, :show, :create, :destroy, :update] do
    post '/users/:user_id', to: 'users_role#create'
    delete '/users/:user_id', to: 'users_role#destroy'
    post '/features/:feature_id', to: 'features_role#create'
    delete '/features/:feature_id', to: 'features_role#destroy'
  end
end
