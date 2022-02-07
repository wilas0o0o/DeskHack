Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  resources :users, only: [:show, :edit, :update] do
    member do
      get :bookmarked_posts
    end
    resource :relationship, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationship#followers', as: 'followers'
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end
