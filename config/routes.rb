Rails.application.routes.draw do
  get '/dealings/incomplete', to: 'dealings#incomplete', as: 'incomplete'
  get '/dealings/requests', to: 'dealings#requests', as: "pay_requests"
  # ^^ must be above dealing resource otherwise thinks it's a show
  resources :dealings
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :users, only: [:show]
  get '/contacts', to: 'users#index', as: 'contacts'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  resources :friends, only: [:index, :show]
  post 'ask', to: 'dealings#ask', as: 'ask'
  post 'pay', to: 'dealings#pay', as: 'pay'
  post 'approve', to: 'dealings#approve', as: 'approve'
  # patch '/dealings/:id', to: 'dealings#update', as: 'approve_dealing'
end
