Rails.application.routes.draw do
  get '/dealings/incomplete', to: 'dealings#incomplete', as: 'incomplete'
  get '/dealings/requests', to: 'dealings#requests', as: "pay_requests"
  # ^^ must be above dealing resource otherwise thinks it's a show
  resources :dealings
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}


  resources :users, only: [:show, :update] do
    resources :dealings
  end

  get '/contacts', to: 'users#index', as: 'contacts'
  get '/add_fund', to: 'users#edit', as: 'add_fund'

  root 'welcome#home'

end
