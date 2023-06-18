Rails.application.routes.draw do
  root to: 'home#index'
  get "home" => 'home#index'
  resources :users, only: [:index]
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  as :user do
    # Auth
    get "signin" => "users/sessions#new"
    post "signin" => "users/sessions#create"
    delete "signout" => "users/sessions#destroy"
    # Register
    get "signup" => "users/registrations#new"
    post "signup" => "users/registrations#create"
    get "signup" => "users/registrations#edit"
    put "signup" => "users/registrations#update"
    delete "signup" => "users/registrations#destroy"
  end
end
