Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'search' => 'searches#search'
  resources :users, only: [:show, :edit, :update] do
    member do
      get :bookmarked
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :notifications, only: [:index]
end
