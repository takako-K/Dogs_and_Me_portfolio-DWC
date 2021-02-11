Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get '/about', to: 'homes#about'
  resources :users do
    resources :events, only: [:index, :create, :update, :destroy] do
      collection do
        get 'json' => 'events#json', as: 'events'          # users show画面への遷移を避ける為
      end
    end
  end
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  delete 'notifications/destroy_all', to: 'notifications#destroy_all'
  resources :notifications, only: :index
end
