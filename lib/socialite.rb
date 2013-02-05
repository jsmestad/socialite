require 'haml'
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-twitter'
require 'omniauth-identity'

module Socialite
  autoload :ControllerSupport, 'socialite/controller_support'
  autoload :ServiceConfig, 'socialite/service_config'

  module ApiWrappers
    autoload :Facebook, 'socialite/api_wrappers/facebook'
    autoload :Twitter, 'socialite/api_wrappers/twitter'
  end

  module Controllers
    autoload :Helpers, 'socialite/controllers/helpers'
  end

  module Helpers
    autoload :Authentication, 'socialite/helpers/authentication.rb'
  end

  module Models
    autoload :Identity, 'socialite/models/identity'
    autoload :User, 'socialite/models/user'
    autoload :FacebookIdentity, 'socialite/models/facebook_identity.rb'
  end

  mattr_accessor :service_configs, :root_path, :mount_prefix, :mounted_engine
  @@service_configs = {}

  def self.generate_token
    SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

  def self.setup(entity = nil, &block)
    block.call self if block_given?
  end

  def self.mounted_engine?
    !!mounted_engine
  end

  # config.twitter APP_KEY, APP_SECRET, :scope => ['foo', 'bar']
  def self.twitter(app_key, app_secret, options = {})
    @@service_configs[:twitter] = ServiceConfig.new(app_key, app_secret, options)
  end

  # config.facebook APP_KEY, APP_SECRET, :scope => ['foo', 'bar']
  def self.facebook(app_key, app_secret, options = {})
    @@service_configs[:facebook] = ServiceConfig.new(app_key, app_secret, options)
  end
end

require 'socialite/engine'
