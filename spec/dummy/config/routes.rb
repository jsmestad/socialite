require 'socialite/engine'

Dummy::Application.routes.draw do
  mount Socialite::Engine => '/socialite'
  # resource :user, :module => 'socialite', :controller => 'user' do
  #   resources :identities, :only => [:destroy]
  # end
  # resource :home
  match '/restricted' => 'home#show', :as => 'restricted'
  root :to => 'home#index'
end
