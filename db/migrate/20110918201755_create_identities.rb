class CreateIdentities < ActiveRecord::Migration
  def up
    create_table :socialite_identities do |t|
      t.integer :user_id, :null => false
      t.string :unique_id, :null => false
      t.string :provider, :null => false
      t.string :access_token
      t.string :access_token_secret
      t.text :auth_hash
      # Any additional fields here

      t.timestamps
    end

    add_index :socialite_identities, :user_id
    add_index :socialite_identities, [:user_id, :provider], :unique => true
    add_index :socialite_identities, [:provider, :unique_id], :unique => true
  end

  def down
    remove_index :socialite_identities, :user_id
    remove_index :socialite_identities, [:user_id, :provider]
    remove_index :socialite_identities, [:user_id, :unique_id]
    drop_table :socialite_identities
  end
end
