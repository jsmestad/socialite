require 'socialite/controller_support'
require 'socialite/service_config'
require 'socialite/engine'

module Socialite
  mattr_accessor :service_configs
  @@service_configs = {}

  def self.setup
    yield self
  end

  # config.twitter APP_KEY, APP_SECRET, :scope => ['foo', 'bar']
  def self.twitter(app_key, app_secret, options = {})
    @@service_configs[:twitter] = ServiceConfig.new(app_key, app_secret, options)
  end

  def self.facebook(app_key, app_secret, options = {})
    @@service_configs[:facebook] = ServiceConfig.new(app_key, app_secret, options)
  end

  def self.linked_in(app_key, app_secret, options ={})
    @@service_configs[:linked_in] = ServiceConfig.new(app_key, app_secret, options)
  end

  def self.github(app_key, app_secret, options ={})
    @@service_configs[:github] = ServiceConfig.new(app_key, app_secret, options)
  end
end
