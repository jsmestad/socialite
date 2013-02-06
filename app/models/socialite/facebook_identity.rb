module Socialite
  class FacebookIdentity < ActiveRecord::Base
    include Models::FacebookIdentity

    self.abstract_class = true
  end
end
