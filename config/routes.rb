Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/about', to: 'homes#about'
  resources :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
