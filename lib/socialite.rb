require 'socialite/controllers/helpers'
require 'socialite/models/identity_concern'
require 'socialite/models/user_concern'
require 'socialite/engine'

module Socialite
  def self.setup
    yield self if block_given?
  end

  mattr_accessor :user_class, :identity_class, :providers

  def self.providers
    @@providers ||= []
  end

  def self.provider(klass, *args)
    @@providers ||= []
    @@providers << [klass, args]
  end

  def self.identity_class
    identity_class_name.try(:constantize)
  end

  def self.identity_class_name
    @@identity_class.try(:camelize) || 'Identity'
  end

  def self.user_class
    user_class_name.try(:constantize)
  end

  def self.user_class_name
    @@user_class.try(:camelize) || 'User'
  end
end
