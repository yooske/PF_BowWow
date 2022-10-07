Rails.application.routes.draw do
  root to: "public/homes#top"

  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :groups, only: [:index, :show, :destroy]
  end
  namespace :admin do
    resources :end_users, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    resources :posts, only: [:show, :destroy]
  end
  namespace :admin do
    root to: "homes#top"
  end
  namespace :public do
    resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
    end
  end
  namespace :public do
    resources :group_chats, only: [:show, :create]
  end
  namespace :public do
    resources :chats, only: [:show, :create]
  end
  namespace :public do
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  namespace :public do
    resources :end_users, only: [:show, :edit, :update] do
      collection do
        get :confirm
        patch :withdraw
      end
      resource:relationships, only:[:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  namespace :public do
    get 'homes/about', as: 'about'
  end

  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
