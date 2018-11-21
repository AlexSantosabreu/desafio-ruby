require 'sidekiq/web'

Rails.application.routes.draw do
  

  devise_for :users

  root to: 'page#index'
  
  get '/lojas', to: 'store#index', as: :store
  get '/loja/:slug', to: 'product#index', as: :product
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
