Rails.application.routes.draw do
  match '/login'                  => 'socialite/session#new',      :as => :login
  match '/auth/:service/callback' => 'socialite/identities#create'
  match '/auth/failure'           => 'socialite/identities#failure'
  match '/logout'                 => 'socialite/session#destroy',  :as => :logout

  resource :user, :controller => 'socialite/user', :except => [:new, :create] do
    resources :identities, :controller => 'socialite/identities', :only => [:destroy]
  end
end
