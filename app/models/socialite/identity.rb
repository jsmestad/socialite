module Socialite
  class Identity < ActiveRecord::Base
    self.abstract_class = true
    include Models::Identity
  end
end
