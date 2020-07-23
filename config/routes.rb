Rails.application.routes.draw do


  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
    get '/sign_up' => 'devise/registrations#new'
  end

  resources :users, :controller => 'users', only: [:edit, :update, :destroy]

  resources :foremen  do
    resources :helpers, only: [:index, :new, :create]
  end

  resources :helpers
end
