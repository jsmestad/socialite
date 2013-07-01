Rails.application.routes.draw do
  get '/signup', :to => 'socialite/users#new'
  match '/auth/:provider/callback', :to => 'socialite/sessions#create', :via => [:get, :post]

  match '/logout', :to => 'socialite/sessions#destroy', :as => 'logout', :via => [:get, :delete]
  get   '/login', :to => 'socialite/sessions#new',      :as => 'login'

  namespace :socialite do 
    resources :users # needed by omniauth-identity
  end
end
