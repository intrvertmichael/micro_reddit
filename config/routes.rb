Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # register and login
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"


  # features
  resources :users, only: [:show]
  resources :posts, only: [:create, :edit, :update, :destroy]
  resources :votes, only: [:update, :edit, :ajax_update, :destroy]
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :comment_votes, only: [:update, :ajax_update, :destroy]


  # custom feature routes
  post :search, to: "static#search"
  get :sort, to: "static#sort"

  get "/posts/:id", to: "posts#show"
  get "/posts/:id/sort" => 'posts#sort', :as => :sort_comment

  get '/ajax/vote/:post_id/:value', to: 'votes#ajax_update'
  get '/ajax/comment_vote/:comment_id/:value', to: 'comment_votes#ajax_update'

  get '/comment_reply', to: 'comments#reply'


  # root
  root to: "static#home"

end