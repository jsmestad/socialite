Rails.application.routes.draw do
  # match '/login'                  => 'omnisocial/auth#new',      :as => :login
  # match '/auth/:service/callback' => 'omnisocial/auth#callback'
  # match '/auth/failure'           => 'omnisocial/auth#failure'
  # match '/logout'                 => 'omnisocial/auth#destroy',  :as => :logout

  # post "#{mount_at}auth/:provider/callback" => 'social-rails/identities#update_or_create'

  # resources :identities, :only => [ :index, :destroy ],
                         # :module => 'billfold',
                         # :path => "#{mount_at}/identities"
end
