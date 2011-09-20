module Socialite
  class User < ActiveRecord::Base
    has_many :facebook_identities, :dependent => :destroy
    has_many :twitter_identities, :dependent => :destroy

    def facebook
      facebook_identities.first
    end

    def twitter
      twitter_identities.first
    end

    def remember
      update_attributes(:remember_token => BCrypt::Password.create("#{Time.now}-#{self.login_account.type}-#{self.login}")) unless new_record?
    end

    def forget
      update_attributes(:remember_token => nil) unless new_record?
    end
  end
end
