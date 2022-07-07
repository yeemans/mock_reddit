Rails.application.routes.draw do
  
  get 'rooms/index'
  resources :messages
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  resources :subreddits, only: [:new, :create]
  resources :posts, only: [:new, :create, :show]
  resources :comments, only: [:new, :create, :show]
  resources :rooms
  resources :users

  resources :rooms do
    resources :messages
  end
  
  # google omniauth 
  get '/auth/:provier/callback' => 'sessions#omniauth'
  
  mount ActionCable.server => '/cable'
  
  root to: "users#feed"
  post "/", to: "users#feed"

  post '/rooms/index', to: 'rooms#index'

  
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

  get '/:name/edit_bio', to: 'users#edit_bio', :as => :edit_bio  
  get '/chat', to: 'users#chat', :as => :chat
  get '/u/:name/messages', to: 'users#messages', :as => :private_messages
  get '/create_liking', to: 'users#create_liking', :as => :create_liking
  get '/posts/:id/upvote', to: 'posts#upvote', :as => :upvote_post
  post '/posts/:id/upvote', to: 'posts#upvote', :as => :upvote_post_test
  get '/comments/:id/upvote', to: 'comments#upvote', :as => :upvote_comment
  get '/comment/:id/:comment_id/reply', to: 'comments#reply', :as => :reply_to_comment

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
