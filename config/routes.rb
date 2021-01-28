Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/about', to: 'homes#about'
  resources :users do
    resources :events, only: [:show, :index, :create, :update, :destroy] do
      collection do
        get 'json' => 'events#json', as: 'events'
      end
    end
  end
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
