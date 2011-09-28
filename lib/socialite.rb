require 'haml'
require 'omniauth/core'
require 'omniauth/oauth'

module Socialite
  autoload :BaseIdentity, 'socialite/base_identity'
  autoload :ServiceConfig, 'socialite/service_config'

  module ApiWrappers
    autoload :Facebook, 'socialite/api_wrappers/facebook'
    autoload :Twitter, 'socialite/api_wrappers/twitter'
  end

  mattr_accessor :service_configs, :root_path, :mount_prefix
  @@service_configs = {}

  def self.generate_token
    SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

  def self.setup(entity = nil, &block)
    block.call self if block_given?
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

require 'socialite/controller_support'
require 'socialite/engine'
