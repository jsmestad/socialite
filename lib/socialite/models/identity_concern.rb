module Socialite
  module Models
    module IdentityConcern
      extend ActiveSupport::Concern

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
end
