require 'sidekiq/web'

ServiceProviderPortal::Application.routes.draw do

  ActiveAdmin.routes(self)

  resources :search, only: :index

  resources :companies, only: [:show, :edit, :update] do
    resources :alerts
    resources :discounts
    resources :users
    resources :company_admins, path: 'users', controller: :users
    resources :administrators, path: 'users', controller: :users
  end

  resource  :account, only: [:show, :edit, :update]

  resources :password_resets, only: [:new, :create, :show, :update],
    constraints: { id: /[a-zA-Z0-9\-_]{12}/ }
  resources :activate, only: [:new, :create, :show, :update], controller: :user_activation,
    constraints: { id: /[a-zA-Z0-9\-_]{12}/ }

  resource :session, only: [:create]

  scope controller: :sessions do
    get :login,  action: :new,     as: :login
    get :logout, action: :destroy, as: :logout
  end

  constraints(proc { |req| uid = req.session[:user_id] and User.find(uid).is_a?(Administrator) }) do
    get '/debug/:action', controller: :debug
    mount Sidekiq::Web => '/sidekiq'
  end

  scope '/follow_us_on', as: :follow_us_on do
    get 'twitter',  to: redirect('https://twitter.com/#!/trustmaster')
    get 'facebook', to: redirect('https://www.facebook.com/pages/Trust-Master/165946716770592')
  end


  root :to => 'search#index'

  get '*slug', controller: :pages, action: :show, as: :page, constraints: RoutingConstraints::Pages
end
