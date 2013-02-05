module Socialite
  class FacebookIdentity < ActiveRecord::Base
    self.abstract_class = true
    include Models::FacebookIdentity
  end
end
