require 'socialite/controller_support'
require 'socialite/engine'

module Socialite
  autoload :BaseIdentity, 'socialite/base_identity'
  autoload :ServiceConfig, 'socialite/service_config'

  module ApiWrappers
    autoload :Facebook, 'socialite/api_wrappers/facebook'
    autoload :Twitter, 'socialite/api_wrappers/twitter'
  end

  mattr_accessor :service_configs
  @@service_configs = {}

  def self.generate_token
    SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

  def self.setup(entity = nil, &block)
    block.call self if block_given?
  end

  def self.root_path(*args, &block)
    @root_path = Proc.new { Rails.application.routes.named_routes[:root].path }
    @root_path = block if block_given?
    @root_path.call(self)
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
