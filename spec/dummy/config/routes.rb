Rails.application.routes.draw do

  # This line mounts Socialite's routes at /socialite by default.
  # This means, any requests to the /socialite URL of your application will go
  # to Socialite::SessionsController#new. If you would like to change where
  # this extension is mounted, simply change the :at option to something
  # different.
  #
  # We ask that you don't use the :as option here, as Socialite relies on it
  # being the default of "socialite"
  mount Socialite::Engine, :at => '/socialite'
  match '/login' => 'socialite/sessions#new', via: [:get]
  match '/logout', :to => 'socialite/sessions#destroy', via: [:get, :post]
  match '/signup', :to => 'socialite/users#new', via: [:get]
  match '/auth/:provider/callback', :to => 'socialite/sessions#create', via: [:post]
  match '/auth/failure', :to => 'socialite/sessions#failure', via: :all

  root :to => "pages#index"
end
