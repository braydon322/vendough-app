Rails.application.routes.draw do
  get '/dealings/incomplete', to: 'dealings#incomplete', as: 'incomplete'
  get '/dealings/requests', to: 'dealings#requests', as: "pay_requests"
  # ^^ must be above dealing resource otherwise thinks it's a show
  resources :dealings
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  # resources :users, only: [:show]

  resources :users, only: [:show] do
    resources :dealings
    get '/add_fund', to: 'users#add_fund', as: 'self_fund'
  end


  get '/contacts', to: 'users#index', as: 'contacts'

  root 'welcome#home'

end
