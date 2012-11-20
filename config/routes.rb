require 'sidekiq/web'

Polyptych::Application.routes.draw do
  resources :panels, only: [:show, :create]
  match '/panels.json', :controller => 'panels', :action => 'options', constraints: {method: 'OPTIONS'}
  
  mount Sidekiq::Web => '/sidekiq'
end
