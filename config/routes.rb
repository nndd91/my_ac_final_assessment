Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :notes do
    resources :likes, only: [:create, :destroy]
  end
  resources :followings, only: [:index, :create, :destroy]
  get '/otherusers', to: 'followings#otherusers'

  root 'notes#index'
end
