module Socialite
  module Models
    module FacebookIdentity
      extend ActiveSupport::Concern

      included do
        include Socialite::ApiWrappers::Facebook

        has_one :identity, :as => :api
        delegate :access_token, :access_token_secret, :to => :identity, :allow_nil => true
      end
    end
  end
end
