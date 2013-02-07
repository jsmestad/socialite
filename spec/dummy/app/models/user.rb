require 'bcrypt'

class User < ActiveRecord::Base
  self.table_name = 'socialite_users'
  include Socialite::Models::UserConcern
end
