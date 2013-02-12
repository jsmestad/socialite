require 'omniauth-identity'
require 'socialite/ext/omniauth/identity/model'

module Socialite
  module Models
    module UserConcern
      extend ActiveSupport::Concern
      include OmniAuth::Identity::Model
      include OmniAuth::Identity::SecurePassword

      included do

        attr_accessible :email, :name, :password, :password_confirmation

        has_secure_password if defined?(BCrypt)

        has_many :identities,
          :dependent => :destroy,
          :class_name => Socialite.identity_class_name,
          :foreign_key => "#{Socialite.user_class.table_name.singularize}_id"

        validates :email,
          :presence => true,
          :format => { :with => /.+@.+\..+/i },
          :uniqueness => { :case_sensitive => false }
      end

      module ClassMethods
        # include OmniAuth::Identity::Model#::ClassMethods
        # include OmniAuth::Identity::SecurePassword::ClassMethods

        def create_from_omniauth(auth)
          create do |user|
            user.name = auth['info']['name']
            user.email = auth['info']['email']
            user.password ||= rand(36**10).to_s(36)
          end
        end

        def auth_key; :email; end

        # def auth_key=(key)
          # super
          # validates_uniqueness_of key, :case_sensitive => false
        # end

        def locate(search_hash)
          where(search_hash).first
        end
      end

      def method_missing(id, *args, &block)
        if id =~ /(\w+)_identity$/ && @identity = self.identities.where(:provider => $1).first
          @identity
        else
          super
        end
      end

      # Returns the first linked facebook identity
      #
      # @return [Identity] the first facebook identity
      def facebook
        self.facebook_identity
      end

      # Returns the first linked twitter account
      #
      # @return [Identity] the first twitter identity
      def twitter
        self.twitter_identity
      end

      # Set the user's remember token
      #
      # @return [User] the current user
      # def remember_me!
        # self.remember_token = Socialite.generate_token
        # save(:validate => false)
      # end

      # Clear the user's remember token
      #
      # @return [User] the current user
      # def forget_me!
        # if persisted?
          # self.remember_token = nil
          # save(:validate => false)
        # end
      # end
    end
  end
end
