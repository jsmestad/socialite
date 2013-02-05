require 'haml'
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-twitter'
require 'omniauth-identity'

module Socialite
  class Engine < Rails::Engine
    isolate_namespace Socialite

    initializer 'socialite.load_middleware', :after => :load_config_initializers do
      if Socialite.service_configs[:identity]
        if Socialite.mounted_engine?
          middleware.use OmniAuth::Strategies::Identity
        else
          config.app_middleware.use OmniAuth::Strategies::Identity
        end
      end

      if Socialite.service_configs[:twitter]
        if Socialite.mounted_engine?
          middleware.use OmniAuth::Strategies::Twitter,
            Socialite.service_configs[:twitter].app_key,
            Socialite.service_configs[:twitter].app_secret
        else
          config.app_middleware.use OmniAuth::Strategies::Twitter,
            Socialite.service_configs[:twitter].app_key,
            Socialite.service_configs[:twitter].app_secret
        end
      end

      if Socialite.service_configs[:facebook]
        if Socialite.mounted_engine?
          middleware.use OmniAuth::Strategies::Facebook,
            Socialite.service_configs[:facebook].app_key,
            Socialite.service_configs[:facebook].app_secret,
            Socialite.service_configs[:facebook].options
        else
          config.app_middleware.use OmniAuth::Strategies::Facebook,
            Socialite.service_configs[:facebook].app_key,
            Socialite.service_configs[:facebook].app_secret,
            Socialite.service_configs[:facebook].options
        end
      end
    end

    ActiveSupport.on_load(:action_controller) do
      include Socialite::Controllers::Helpers
    end

    ActiveSupport.on_load(:action_view) do
      include Socialite::Helpers::Authentication
    end
  end
end
