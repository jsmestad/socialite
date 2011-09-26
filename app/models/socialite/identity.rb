module Socialite
  class Identity < ActiveRecord::Base
    belongs_to :api, :polymorphic => true, :dependent => :destroy
    include BaseIdentity
  end
end
