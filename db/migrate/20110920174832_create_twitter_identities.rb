class CreateTwitterIdentities < ActiveRecord::Migration
  def up
    create_table :socialite_twitter_identities do |t|
      t.integer :user_id, :null => false
      t.string :unique_id, :null => false
      t.string :provider, :null => false
      t.text :auth_hash
      # Any additional fields here

      t.timestamps
    end

    add_index :socialite_twitter_identities, :user_id, :unique => true
    add_index :socialite_twitter_identities, :unique_id, :unique => true
  end

  def down
    remove_index :socialite_twitter_identities, :user_id
    remove_index :socialite_twitter_identities, :unique_id
    drop_table :socialite_twitter_identities
  end
end
