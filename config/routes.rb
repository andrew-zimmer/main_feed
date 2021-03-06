Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
    get '/sign_up' => 'devise/registrations#new'
  end

  #user foreman and helper routes and actions
  get '/users/contacts' => 'users#contacts'
  resources :users, :controller => 'users', only: [:edit, :update, :destroy, :index, :show] do
    resources :users_badges, only: [:new]
    resources :schedules, only: %i[index]
  end

  get "/foremen/contacts" => "foremen#contacts"

  resources :foremen  do
    resources :helpers, only: [:index, :new]
  end

  get "/helpers/contacts" => 'helpers#contacts'
  resources :helpers

  # badge users_baage routes and actions
  resources :badges do
    resources :users_badges, only: %i[index new]
  end

  resources :users_badges

  #project and schedule routes
  resources :projects do
    resources :schedules, only: %i[index new]
  end

  resources :schedules
end
