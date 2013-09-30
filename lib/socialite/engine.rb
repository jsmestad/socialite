require 'haml'
require 'omniauth'
require 'protected_attributes' if Rails.version =~ /^4/

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

    initializer 'socialite.load_middleware' do |app|
      app.middleware.use OmniAuth::Builder do
        Socialite.providers.each do |provider_info|
          provider(provider_info.first, *provider_info.last)
        end
      end
    end

    ActiveSupport.on_load(:action_controller) do
      include Socialite::Controllers::Helpers
    end
  end
end
