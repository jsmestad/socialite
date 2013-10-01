Socialite::Engine.routes.draw do
  get '/signup', :to => 'users#new'
  match '/auth/:provider/callback', :to => 'socialite/sessions#create', :via => [:get, :post]

  match '/logout', :to => 'socialite/sessions#destroy', :as => 'logout', :via => [:get, :delete]
  get '/login', :to => 'sessions#new', :as => 'login'

  namespace :socialite do
    resources :users # needed by omniauth-identity
  end
end
