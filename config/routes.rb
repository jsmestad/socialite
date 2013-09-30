Socialite::Engine.routes.draw do
  match '/signup', :to => 'users#new', via: [:get]
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:post]

  match '/logout', :to => 'sessions#destroy', :as => 'logout', via: [:all]
  match '/login', :to => 'sessions#new', :as => 'login', via: [:get]

  resources :users # needed by omniauth-identity
end
