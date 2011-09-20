module Socialite
  class FacebookIdentity < ActiveRecord::Base
    include Identity

  protected

    def connection
      # Koala::Facebook::API.new("#{usertoken}")
    end
  end
end
