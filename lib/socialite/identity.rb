module Socialite
  module Identity
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      serialize :auth_hash

      # Before saving an identity, we ensure that the provider name
      # is downcased. This avoids any issue when using PostgreSQL
      # without ILIKE logic.
      before_validation do |identity|
        if identity.auth_hash.present? and identity.auth_hash.has_key?('provider')
          identity.provider = identity.auth_hash['provider']
        end
      end

      before_save do |identity|
        identity.provider = identity.provider.downcase
      end

      # Ensure each user has only a single identity per provider type
      validates :provider,
        :uniqueness => {:scope => :user_id, :case_sensitive => false},
        :presence => true

      # Ensure an identity is never reused by another account
      validates :unique_id,
        :uniqueness => {:scope => :provider},
        :presence => true

      validates_associated :user
    end

    module ClassMethods
      # Placeholder for any common class methods
    end

    module InstanceMethods
      def access_token
        credentials['token']
      end

      def access_token_secret
        credentials['secret']
      end

      def credentials
        auth_hash['credentials']
      end

      def nickname
        user_info['nickname']
      end

      def user_info
        auth_hash['user_info']
      end
    end
  end
end
