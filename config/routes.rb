Rails.application.routes.draw do
  resources :transactions
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  resources :friends, only: [:index, :show]
  post 'ask', to: 'transactions#ask', as: 'ask'
  post 'pay', to: 'transactions#pay', as: 'pay'
end
