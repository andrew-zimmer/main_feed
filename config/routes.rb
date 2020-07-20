Rails.application.routes.draw do
  root 'home#index'

  devise_for :users do
    resources :foremen, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :foremen, only: [:index, :show, :new, :create, :edit, :update] do
    resources :helpers, only: [:index, :show]
  end

  resources :helpers, only: [:index, :show]
end
