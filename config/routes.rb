Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { sessions: "users/sessions" }
  resources :users
  resources :subreddits, only: [:new, :create]
  resources :posts, only: [:new, :create, :show]

  root to: "users#feed"
  get '/r/:title', to: 'subreddits#show'
  post '/r/:title/subscribe', to: 'subreddits#subscribe', :as => :subscribe
  post '/r/:title/unsubscribe', to: 'subreddits#unsubscribe', :as => :unsubscribe

  get '/feed', to: 'users#feed', :as => :feed
  get '/u/:name', to: 'users#profile', :as => :profile
  get '/edit_profile', to: 'users#edit_profile', :as => :profile_edit
  post '/u/:name', to: 'users#update', :as => :update

  post '/search', to: 'subreddits#search', :as => :search

  


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
