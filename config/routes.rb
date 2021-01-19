Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]

  resources :users
  resources :posts
  resources :votes
  resources :comments
  resources :comment_votes

  post :search, to: "static#search"

  get :sort, to: "static#sort"

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"


  get "/posts/:id", to: "posts#show"
  put :edit_post, to: "posts#update"

  get "/posts/:id/sort" => 'posts#sort', :as => :sort_comment

  root to: "static#home"



  get '/ajax/vote/:post_id/:value', to: 'votes#ajax_update'
  get '/ajax/comment_vote/:comment_id/:value', to: 'comment_votes#ajax_update'

end