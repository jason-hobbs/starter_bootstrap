Rails.application.routes.draw do
  root 'pages#home'
  get 'register' => 'users#new'
  get 'forgot_password' => 'users#forgot'
  post 'reset_password' => 'users#reset'
  get 'sign_in' => 'sessions#new'
  get 'sign_out' => 'sessions#destroy'
  resources :users
  resources :sessions, only: [:create]
end
