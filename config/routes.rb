Rails.application.routes.draw do
  root to: "public/homes#top"

  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :groups, only: [:index, :show, :destroy]
  end
  namespace :admin do
    resources :end_users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get 'posts' => 'end_users#posts', as: 'posts'
      end
    end
  end
  namespace :admin do
    resources :posts, only: [:show, :destroy] do
      resources :comments, only: [:destroy]
    end
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
    resources :contacts, only: [:new, :create, :index] do
      collection do
        get :complete
      end
    end
  end
  namespace :public do
    resources :rooms, only: [:index]
  end
  namespace :public do
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  namespace :public do
    resources :end_users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get 'posts' => 'end_users#posts', as: 'posts'
      end
      collection do
        get :confirm
      end
      resource:relationships, only:[:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  namespace :public do
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    get 'homes/about', as: 'about'
  end

  namespace :public do
    get '/search', to: 'searches#search'
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
