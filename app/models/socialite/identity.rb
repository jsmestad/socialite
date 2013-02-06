module Socialite
  class Identity < ActiveRecord::Base
    include Models::Identity
    self.abstract_class = true
  end
end
