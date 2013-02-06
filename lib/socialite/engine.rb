require 'haml'
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-twitter'
require 'omniauth-identity'

module Socialite
  class Engine < ::Rails::Engine
    isolate_namespace Socialite

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.integration_tool :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer 'socialite.load_middleware', :after => :load_config_initializers do
      Socialite.providers.each do |provider_info|
        OmniAuth.configure do |config|
          config.provider(*provider_info)
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
