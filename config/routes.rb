Rails.application.routes.draw do
  match '/login'                  => 'socialite/authenticate#new',      :as => :login
  match '/auth/:service/callback' => 'socialite/authenticate#callback'
  match '/auth/failure'           => 'socialite/authenticate#failure'
  match '/logout'                 => 'socialite/authenticate#destroy',  :as => :logout
end
