class Identity < ActiveRecord::Base
  self.table_name = 'socialite_identities'
  include Socialite::IdentityConcern
end
