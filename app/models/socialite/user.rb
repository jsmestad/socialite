module Socialite
  class User < ActiveRecord::Base
    include Models::User
    self.abstract_class = true
  end
end
