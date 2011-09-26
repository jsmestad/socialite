require 'haml'
require 'omniauth/core'
require 'omniauth/oauth'

module Socialite
  class Engine < Rails::Engine
    isolate_namespace Socialite

    initializer 'socialite.load_middleware', :after => :load_config_initializers do
      if Socialite.service_configs[:twitter]
        config.app_middleware.use OmniAuth::Strategies::Twitter,
          Socialite.service_configs[:twitter].app_key,
          Socialite.service_configs[:twitter].app_secret
      end

      if Socialite.service_configs[:facebook]
        config.app_middleware.use OmniAuth::Strategies::Facebook,
          Socialite.service_configs[:facebook].app_key,
          Socialite.service_configs[:facebook].app_secret,
          Socialite.service_configs[:facebook].options
      end
    end

    ActiveSupport.on_load(:action_controller) do
      include Socialite::ControllerSupport
    end

    ActiveSupport.on_load(:action_view) do
      include Socialite::AuthenticationHelper
    end
  end
end
