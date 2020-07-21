Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
    get '/sign_up' => 'devise/registrations#new'
  end

  resources :users, :controller => 'users', only: [:edit, :update, :destroy]

  resources :foremen, only: [:index, :show, :new, :create, :edit, :update] do
    resources :helpers, only: [:index, :show]
  end

  resources :helpers, only: [:index, :show]
end
