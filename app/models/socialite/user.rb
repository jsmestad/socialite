module Socialite
  class User < ActiveRecord::Base
    include Models::User

    has_one :facebook_identity,
      :class_name => 'Identity', :foreign_key => 'user_id', :conditions => { :provider => 'facebook' }
    has_one :twitter_identity,
      :class_name => 'Identity', :foreign_key => 'user_id', :conditions => { :provider => 'twitter' }

    self.abstract_class = true
  end
end
