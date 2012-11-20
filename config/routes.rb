require 'sidekiq/web'

Polyptych::Application.routes.draw do
  resources :panels, only: [:show, :create]
  match 'panels/:id.:cache_busting' => 'panels#show'
  mount Sidekiq::Web => '/sidekiq'
end
