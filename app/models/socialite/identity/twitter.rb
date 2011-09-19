module Socialite
  class Twitter
    extend ActiveSupport::Concern

    module InstanceMethods
      def assign_account_info(auth_hash)
        self.uid   = auth_hash['uid']
        self.login               = auth_hash['user_info']['nickname']
        self.picture_url         = auth_hash['user_info']['image']
        self.name                = auth_hash['user_info']['name']
        self.access_token        = auth_hash['credentials']['token']
        self.access_token_secret = auth_hash['credentials']['secret']
      end

      def account_url
        "http://twitter.com/#{self.login}"
      end
    end
  end
end
