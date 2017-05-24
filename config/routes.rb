Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'index#index'

  resources :players
  resources :games, only: [:index, :show, :create, :new, :update]
end
