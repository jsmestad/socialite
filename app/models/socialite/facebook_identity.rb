module Socialite
  class FacebookIdentity < ActiveRecord::Base
    has_one :identity, :as => :api
    delegate :access_token, :access_token_secret, :to => :identity, :allow_nil => true
    include ApiWrappers::Facebook
  end
end
