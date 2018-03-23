Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :replays, only: %i[index show create]
  resources :players, only: %i[index]
  resources :commands, only: %i[index]
  resources :chat_messages, only: %i[index]
end
