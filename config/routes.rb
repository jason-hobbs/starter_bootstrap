Rails.application.routes.draw do
  root 'pages#home'
  get 'register' => 'users#new'
  get 'forgot_password' => 'users#forgot'
  post 'reset_password' => 'users#reset'
  patch 'set_pass' => 'users#set_pass'
  get 'sign_in' => 'sessions#new'
  get 'sign_out' => 'sessions#destroy'
  get 'new_password' => 'users#new_password'
  resources :users
  resources :sessions, only: [:create]
end
