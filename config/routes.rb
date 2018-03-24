Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :auth, only: %i[create], controller: :auth
  resources :replays, only: %i[index show create]
  resources :players, only: %i[index]
  resources :commands, only: %i[index]
  resources :chat_messages, only: %i[index]
  resources :users, only: %i[] do
    get :me, on: :collection
  end
end
