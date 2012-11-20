require 'sidekiq/web'

Polyptych::Application.routes.draw do
  resources :panels, only: [:show, :create]
  mount Sidekiq::Web => '/sidekiq'
end
