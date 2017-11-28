Rails.application.routes.draw do
  get '/transactions/incomplete', to: 'transactions#incomplete', as: 'incomplete'
  get '/transactions/requests', to: 'transactions#requests', as: "pay_requests"
  # ^^ must be above transaction resource otherwise thinks it's a show
  resources :transactions
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :users, only: [:show]
  get '/contacts', to: 'users#index', as: 'contacts'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  resources :friends, only: [:index, :show]
  post 'ask', to: 'transactions#ask', as: 'ask'
  post 'pay', to: 'transactions#pay', as: 'pay'
  post 'approve', to: 'transactions#approve', as: 'approve'
end
