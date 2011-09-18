require 'socialite'

module Socialite
  class Engine < Rails::Engine
    isolate_namespace Socialite

    config.to_prepare do
      ApplicationController.helper(Socialite::AuthHelper)
    end

    initializer 'Socialite.load_middleware', :after => :load_config_initializers do
      if Socialite.service_configs[:twitter]
        config.app_middleware.use ::OmniAuth::Strategies::Twitter,
          Socialite.service_configs[:twitter].app_key,
          Socialite.service_configs[:twitter].app_secret
      end

      if Socialite.service_configs[:facebook]
        config.app_middleware.use ::OmniAuth::Strategies::Facebook,
          Socialite.service_configs[:facebook].app_key,
          Socialite.service_configs[:facebook].app_secret,
          Socialite.service_configs[:facebook].options
      end

      if Socialite.service_configs[:linked_in]
        config.app_middleware.use ::OmniAuth::Strategies::LinkedIn,
          Socialite.service_configs[:linked_in].app_key,
          Socialite.service_configs[:linked_in].app_secret
      end

      if Socialite.service_configs[:github]
        config.app_middleware.use ::OmniAuth::Strategies::GitHub,
          Socialite.service_configs[:github].app_key,
          Socialite.service_configs[:github].app_secret
      end
    end

  end
end
