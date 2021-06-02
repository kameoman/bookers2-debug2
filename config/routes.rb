Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'


  resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :post_comments, only: [:create, :destroy]
  end

  resources :users,only: [:show,:index,:edit,:update] do
    resource :follow
    resource :followings
    resource :followers
    
  end



end