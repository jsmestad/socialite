module Socialite
  class User < ActiveRecord::Base
    has_many :identities, :inverse_of => :user, :dependent => :destroy

    def facebook_identities
      find_identities('twitter')
    end

    def facebook
      facebook_identities.first
    end

    def twitter_identities
      find_identities('twitter')
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

  protected

    def find_identities(name)
      self.identities.send(name.to_sym).order('created_at DESC').all
    end
  end
end
