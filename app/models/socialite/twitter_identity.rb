module Socialite
  class TwitterIdentity < ActiveRecord::Base
    include Identity

    def account_url
      @account_url ||= "http://twitter.com/#{self.login}"
    end
  end
end
