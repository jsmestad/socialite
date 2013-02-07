module Socialite
  module Models
    module UserConcern
      extend ActiveSupport::Concern

      included do
        has_secure_password if defined?(BCrypt)

        has_many :identities,
          :dependent => :destroy,
          :class_name => Socialite.identity_class_name,
          :foreign_key => "#{Socialite.user_class.table_name.singularize}_id"
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
