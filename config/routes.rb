Rails.application.routes.draw do
  devise_for :users

  
  resources :users do
  	resource :profile
  end

  resources :stories do
    resources :comments
  end

  resources :comments do
    resources :comments
  end
  
  root to: 'pages#index'

  match 'like', to: 'likes#like', via: :post

  match 'unlike', to: 'likes#unlike', via: :delete

  match 'dislike', to: 'likes#dislike', via: :post

  match 'undislike', to: 'likes#undislike', via: :delete
  
  #get 'pages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
