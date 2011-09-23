module Socialite
  module BaseIdentity
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      serialize :auth_hash

      # Ensure that before validation happens that the provider
      # database column matches what is inside of the auth_hash
      # dataset.
      before_validation do |identity|
        if identity.auth_hash.present?
          identity.provider = identity.auth_hash.delete('provider') if identity.provider.blank?
          identity.unique_id = identity.auth_hash.delete('uid') if identity.unique_id.blank?
        end
      end

      # Ensure each user has only a single identity per provider type
      validates :provider,
        :uniqueness => {:scope => :user_id, :case_sensitive => false},
        :presence => true

      # Ensure an identity is never reused by another account
      validates :unique_id,
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
      def find_or_initialize_by_oauth(auth_hash)
        identity = where(:provider => auth_hash['provider'], :unique_id => auth_hash['uid']).first || new
        identity.auth_hash = auth_hash
        identity
      end
    end

    module InstanceMethods
      # Method that maps uid to unique_id which is what we store it as.
      #
      # @returns [String]
      # def uid=(new_uid)
      #   self.unique_id = new_uid
      # end

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
        user_info['nickname']
      end

      # Convenience method for accessing the user information from the
      # OAuth provider.
      #
      # @returns [Hash] the user information sub-hash
      def user_info
        auth_hash['user_info']
      end
    end
  end
end
