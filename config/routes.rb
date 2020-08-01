Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :clients do
    resources :products
  end

  resources :products do
    resources :clients
  end

  resources :users
end
