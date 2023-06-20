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


  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
    end

    resources :post_camps do
      resource :favorites, only: [:create, :destroy]
      resources :post_camp_comments, only: [:create, :destroy]
    end

    get "search" => "searches#search"
  end


  namespace :admin do
    root to: 'homes#top'

    resources :users, only: [:show, :edit, :update]

    resources :post_camps do
      resource :favorites, only: [:create, :destroy]
      resources :post_camp_comments, only: [:create, :destroy]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
