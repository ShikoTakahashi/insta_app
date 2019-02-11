Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get '/' => 'static_pages#home', as: 'root'
  resources :users, only: [:show]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:new, :show, :create, :destroy]
  resources :replayposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
