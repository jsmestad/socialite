module Socialite
  class User < ActiveRecord::Base
    has_many :facebook_identities, :dependent => :destroy
    has_many :twitter_identities, :dependent => :destroy

    # Create or update a user by identity
    #
    # @param [String] name of the provider i.e. 'facebook'
    # @param [Hash] the resultant OmniAuth auth_hash returned after authenticating with a provider
    # @return [User] the created or updated user
    def self.create_or_update_by_identity(provider, auth_hash)
      provider = "#{provider}_identity".classify
      return nil unless Socialite.constants.include?(provider.to_sym)

      identity_class = Socialite.const_get(provider.to_sym)
      identity = identity_class.send(:find_or_initialize_by_unique_id, auth_hash['uid'])

      identity.user = new if identity.user.blank?
      identity.auth_hash = auth_hash
      identity.save
      identity.user
    end

    # Returns the first linked facebook identity
    #
    # @return [Identity] the first facebook identity
    def facebook
      facebook_identities.first
    end

    # Returns the first linked twitter account
    #
    # @return [Identity] the first twitter identity
    def twitter
      twitter_identities.first
    end

    # Set the user's remember token
    #
    # @return [User] the current user
    def remember
      update_attributes(:remember_token => BCrypt::Password.create("#{Time.now}-#{self.login_account.type}-#{self.login}")) unless new_record?
    end

    # Clear the user's remember token
    #
    # @return [User] the current user
    def forget
      update_attributes(:remember_token => nil) unless new_record?
    end
  end
end
