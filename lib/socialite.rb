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
    autoload :Identity, 'socialite/models/identity'
    autoload :User, 'socialite/models/user'
    autoload :FacebookIdentity, 'socialite/models/facebook_identity.rb'
  end

  mattr_accessor :user_class, :identity_class, :providers

  def self.user_class
    @@user_class.constantize
  end

  def self.providers
    @@providers ||= []
  end

  def self.provider(klass, *args)
    @@providers ||= []
    @@providers << [klass, args]
  end

  def self.identity_class
    @@identity_class.constantize
  end

  def self.setup
    yield self if block_given?
  end
end

