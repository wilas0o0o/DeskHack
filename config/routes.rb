Rails.application.routes.draw do
  devise_for :users, skip: [:passwords, :registrations, :sessions]
  devise_scope :user do
    get 'sign_up', to: 'devise/registrations#new', as: :new_user_registration
    post 'sign_up', to: 'devise/registrations#create', as: :user_registration
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    post 'guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'homes#top'
  get 'search' => 'searches#search'
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resources :items, only: [:create, :destroy]
  end
  get '/hashtags/:name' => 'posts#hashtag'
  patch 'check' => 'notifications#check'
  resources :users, path: '/', only: [:show, :edit, :update] do
    member do
      get :bookmarked
      get :unsubxcribe
      patch :withdrawal
    end
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
