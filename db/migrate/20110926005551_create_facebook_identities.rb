class CreateFacebookIdentities < ActiveRecord::Migration
  def up
    create_table :socialite_facebook_identities do |t|
      # Additional Fields that you want to cache
      t.timestamps
    end
  end

  def down
    drop_table :socialite_facebook_identities
  end
end
