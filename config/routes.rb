Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]

  resources :users
  resources :posts

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  get "/posts/:id", to: "posts#show"
  put :edit_post, to: "posts#update"

  root to: "static#home"


end
