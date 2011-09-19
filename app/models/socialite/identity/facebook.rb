module Socialite
  module Facebook
    extend ActiveSupport::Concern

    module InstanceMethods
      def assign_account_info(auth_hash)
        self.uid   = auth_hash['uid']
        self.login               = auth_hash['user_info']['nickname']
        self.name                = auth_hash['user_info']['name']
        self.access_token        = auth_hash['credentials']['token']
      end

      def account_url
        "http://facebook.com/#{self.login}"
      end

      def picture_url
        if self.login.include?('profile.php')
          "https://graph.facebook.com/#{self.login.gsub(/[^\d]/, '')}/picture?type=square"
        else
          "https://graph.facebook.com/#{self.login}/picture?type=square"
        end
      end
    end
  end
end
