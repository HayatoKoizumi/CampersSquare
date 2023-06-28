Rails.application.routes.draw do

  # 顧客用
  # URL /users/singn_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    get '/users/check' => 'users#check'
    patch '/users/withdraw' => 'users#withdraw'

    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'

      member do
        get :favorites
      end
    end

    resources :post_camps do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    get "search" => "searches#search"

    get "search_tag" => "post_camps#search_tag"
  end


  namespace :admin do
    root to: 'users#index'

    resources :users, only: [:index, :show, :edit, :update]

    resources :post_camps do
      resources :comments, only: [:destroy]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
