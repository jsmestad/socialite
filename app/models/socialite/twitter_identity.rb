module Socialite
  class TwitterIdentity < ActiveRecord::Base
    include Identity

  protected

    def api_connection

    end
  end
end
