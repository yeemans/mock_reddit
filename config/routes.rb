Rails.application.routes.draw do
  
  devise_for :users, controllers: { sessions: "users/sessions" }
  resources :users, only: [:delete]
  resources :subreddits, only: [:new, :create]
  resources :posts, only: [:new, :create, :show]

  root to: "users#feed"

  get '/r/:title', to: 'subreddits#show', :as => :r
  post '/r/:title/subscribe', to: 'subreddits#subscribe', :as => :subscribe
  post '/r/:title/unsubscribe', to: 'subreddits#unsubscribe', :as => :unsubscribe
  post '/r/:title', to: 'subreddits#update', :as => :subreddit_update

  get '/feed', to: 'users#feed', :as => :feed
  get '/u/:name', to: 'users#profile', :as => :profile
  get '/edit_profile', to: 'users#edit_profile', :as => :profile_edit
  post '/u/:name', to: 'users#update', :as => :update

  post '/search', to: 'subreddits#search', :as => :search
  get '/search', to: 'subreddits#search'
  


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
