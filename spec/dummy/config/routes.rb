Dummy::Application.routes.draw do
  # mount Socialite::Engine => '/', :as => 'socialite'
  # resource :home
  match '/restricted' => 'home#show', :as => 'restricted'
  root :to => 'home#index'
end
