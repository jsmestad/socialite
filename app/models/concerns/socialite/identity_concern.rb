module Socialite
  module IdentityConcern
    extend ActiveSupport::Concern

    included do
      belongs_to :user,
        :class_name => Socialite.user_class_name,
        :foreign_key => "#{Socialite.user_class.table_name.singularize}_id"
      serialize :auth_hash

      # Ensure that before validation happens that the provider
      # database column matches what is inside of the auth_hash
      # dataset.
      before_validation do |identity|
        if identity.auth_hash.present?
          identity.provider = identity.auth_hash.delete('provider') if identity.provider.blank?
          identity.uid = identity.auth_hash.delete('uid') if identity.uid.blank?
        end
      end

      # Ensure each user has only a single identity per provider type
      validates :provider,
        :uniqueness => {
          :scope => "#{Socialite.user_class.table_name.singularize}_id",
          :case_sensitive => false
        },
        :presence => true

      # Ensure an identity is never reused by another account
      validates :uid,
        :uniqueness => {:scope => :provider},
        :presence => true

      # Ensure an associated user exists before creating the identity
      # validates_associated :user
    end

    module ClassMethods
      # Finder method that finds the matching Provider and Unique ID or
      # initializes a new, unsaved, object.
      #
      # @params [Hash] the OAuth authentication hash
      # @returns [Identity]
      def create_from_omniauth(auth={})
        create do |identity|
          identity.provider = auth['provider']
          identity.uid = auth['uid']
          identity.auth_hash = auth
        end
      end

      def find_or_create_from_omniauth(auth)
        raise ArgumentError, 'auth parameter must be a hash' unless auth.is_a?(Hash)
        find_from_omniauth(auth) || create_from_omniauth(auth)
      end

      # Finder method that finds the matching Provider and UID.
      #
      # @params [Hash] the OmniAuth authentication hash
      def find_from_omniauth(auth={})
        where(:provider => auth['provider'], :uid => auth['uid']).first
      end
    end

    # Convenience method for accessing the OAuth access token
    #
    # @returns [String] OAuth access token
    # (see #credentials)
    def access_token
      credentials['token']
    end

    # Convenience method for accessing the OAuth access token secret
    #
    # @returns [String] OAuth access token secret
    # (see #credentials)
    def access_token_secret
      credentials['secret']
    end

    # Convenience method for accessing the OAuth credentials sub-hash
    #
    # @returns [Hash] OAuth credentials sub-hash
    # (see #access_token)
    # (see #access_token_secret)
    def credentials
      auth_hash['credentials']
    end

    # Convenience method for accessing the nickname, which is typically
    # set to the login name used for that provider.
    #
    # @returns [String] user nickname for the provider identity
    def nickname
      info['nickname']
    end

    # Convenience method for accessing the user information from the
    # OAuth provider.
    #
    # @returns [Hash] the user information sub-hash
    def info
      auth_hash['info']
    end
  end
end
