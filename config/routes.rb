Polyptych::Application.routes.draw do
  resources :panels, only: [:show, :create]
end
