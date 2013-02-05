module Socialite
  module Models
    module User
      extend ActiveSupport::Concern

      included do
        has_many :identities, :dependent => :destroy

        # has_one :facebook_identity,
          # :class_name => 'Identity', :foreign_key => 'user_id', :conditions => { :provider => 'facebook' }
        # has_one :twitter_identity,
          # :class_name => 'Identity', :foreign_key => 'user_id', :conditions => { :provider => 'twitter' }
      end

      # Returns the first linked facebook identity
      #
      # @return [FacebookIdentity] the first facebook identity
      def facebook
        self.facebook_identity.api
      end

      # Returns the first linked twitter account
      #
      # @return [TwitterIdentity] the first twitter identity
      def twitter
        self.twitter_identity.api
      end

      # Set the user's remember token
      #
      # @return [User] the current user
      def remember_me!
        self.remember_token = Socialite.generate_token
        save(:validate => false)
      end

      # Clear the user's remember token
      #
      # @return [User] the current user
      def forget_me!
        if persisted?
          self.remember_token = nil
          save(:validate => false)
        end
      end
    end
  end
end
