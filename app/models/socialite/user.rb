module Socialite
  class User < ActiveRecord::Base
    self.abstract_class = true

    has_one :login_account, :class_name => 'Socialite::LoginAccount', :dependent => :destroy
    delegate :login, :name, :picture_url, :account_url, :access_token, :access_token_secret, :to => :login_account

    def to_param
      if !self.login.include?('profile.php?')
        "#{self.id}-#{self.login.gsub('.', '-')}"
      else
        self.id.to_s
      end
    end

    def from_twitter?
      login_account.kind_of? TwitterAccount
    end

    def from_facebook?
      login_account.kind_of? FacebookAccount
    end

    def from_linked_in?
      login_account.kind_of? LinkedInAccount
    end

    def from_github?
      login_account.kind_of? GithubAccount
    end

    def remember
      update_attributes(:remember_token => BCrypt::Password.create("#{Time.now}-#{self.login_account.type}-#{self.login}")) unless new_record?
    end

    def forget
      update_attributes(:remember_token => nil) unless new_record?
    end
  end
end
