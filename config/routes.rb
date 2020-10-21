Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :clients, only: %i[create index show update] do
    resources :products, only: %i[index show] do
      resources :roles, only: %i[index show destroy]
    end
  end

  resources :products, only: %i[create index show update] do
    resources :features, only: %i[create index show destroy]
    resources :clients, only: %i[index show] do
      resources :roles, only: %i[index show destroy]
    end
  end

  resources :contracts, only: %i[create index]

  resources :users, only: %i[index show create destroy update] do
    resources :contracts, only: [:index] do
      resources :features, only: [:index]
    end
    post '/roles/:role_id', to: 'users_role#create'
    delete '/roles/:role_id', to: 'users_role#destroy'
  end

  resources :features, only: %i[create index show destroy update] do
    post '/roles/:role_id', to: 'features_role#create'
    delete '/roles/:role_id', to: 'features_role#destroy'
  end

  resources :roles, only: %i[index show create destroy update] do
    post '/users/:user_id', to: 'users_role#create'
    delete '/users/:user_id', to: 'users_role#destroy'
    post '/features/:feature_id', to: 'features_role#create'
    delete '/features/:feature_id', to: 'features_role#destroy'
  end
end
