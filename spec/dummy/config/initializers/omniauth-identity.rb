require 'omniauth-identity'
require 'omniauth/identity'

Socialite.setup do |config|
  config.provider :identity,
    :model => User,
    :fields => [:email],
    :on_failed_registration => Socialite::UsersController.action(:new)
end
