Rails.application.routes.draw do
  root 'pages#home'
  get 'register' => 'users#new'
  get 'sign_in' => 'sessions#new'
  get 'sign_out' => 'sessions#destroy'
  resources :users, only: [:create, :show, :edit, :update, :destroy]
  resources :sessions, only: [:create]
end
