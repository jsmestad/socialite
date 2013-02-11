require 'socialite/engine'

require 'haml'
require 'omniauth'

module Socialite
  autoload :ControllerSupport, 'socialite/controller_support'

  module Controllers
    autoload :Helpers, 'socialite/controllers/helpers'
  end

  module Helpers
    autoload :Authentication, 'socialite/helpers/authentication.rb'
  end

  module Models
    autoload :IdentityConcern, 'socialite/models/identity_concern'
    autoload :UserConcern, 'socialite/models/user_concern'
  end

  def self.setup
    yield self if block_given?
  end

  mattr_accessor :user_class, :identity_class, :providers

  def self.providers
    @@providers ||= []
  end

  def self.provider(klass, *args)
    @@providers ||= []
    case klass.to_sym
    when :identity
      args.reverse_merge!({:model => Socialite.user_class})
    end
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
