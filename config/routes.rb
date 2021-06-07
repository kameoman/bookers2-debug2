Rails.application.routes.draw do
  # 検索アクションへ
  get '/search' => 'search#search'
  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'


  resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :post_comments, only: [:create, :destroy]
  end

  resources :users,only: [:show,:index,:edit,:update] do
    get "search", to: "users#search"
    resource :follow
    resource :followings
    resource :followers

  end



end