Socialite::Engine.routes.draw do
  match '/signup', :to => 'users#new'
  match '/auth/:provider/callback', :to => 'sessions#create'

  match '/logout', :to => 'sessions#destroy', :as => 'logout'
  match '/login', :to => 'sessions#new', :as => 'login'

  resources :users # needed by omniauth-identity
end
