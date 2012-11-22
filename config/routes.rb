require 'sidekiq/web'

Polyptych::Application.routes.draw do

  resources :panels, only: [:show, :create] do
    member do
      get :status
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
