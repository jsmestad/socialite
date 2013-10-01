require 'socialite/controllers/helpers'
require 'socialite/models/identity_concern'
require 'socialite/models/user_concern'
require 'socialite/engine'

module Socialite
  include ActiveSupport::Configurable

  config_accessor :use_omniauth_identity

  def self.user_class_name
    @user_class_name || 'User'
  end

  def self.identity_class_name
    @identity_class_name || 'Identity'
  end

  def self.user_class_name=(name)
    @user_class_name = name
  end

  def self.identity_class_name=(name)
    @identity_class_name = name
  end

  def self.setup
    yield self if block_given?
  end

  def self.providers=(providers)
    @providers = providers
  end

  def self.providers;
    @providers ||= []
  end

  def self.provider(klass, *args)
    providers << [klass, args]
  end

  def self.identity_class
    identity_class_name.try(:constantize)
  end

  def self.user_class
    user_class_name.try(:constantize)
  end
end
