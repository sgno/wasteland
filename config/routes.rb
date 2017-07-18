Rails.application.routes.draw do\
  devise_for :users

  resources :friendships,   only: [:create, :update, :destroy]
  resources :users,         only: [:index, :show, :edit, :update]

  resources :posts,         only: [:create] do
    resources :comments,    only: [:create]
  end
  resources :likes,         only: [:create, :destroy]

  root 'static_pages#home'
end
