class CreateIdentities < ActiveRecord::Migration
  def up
    create_table :socialite_identities do |t|
      t.belongs_to :user
      t.references :api, :polymorphic => true

      t.string :unique_id, :null => false
      t.string :provider, :null => false
      t.text :auth_hash
      t.timestamps
    end

    add_index :socialite_identities, :user_id
    add_index :socialite_identities, [:api_id, :api_type]
    add_index :socialite_identities, [:user_id, :provider], :unique => true
    add_index :socialite_identities, [:provider, :unique_id], :unique => true
  end

  def down
    remove_index :socialite_identites, :user_id
    remove_index :socialite_identites, [:api_id, :api_type]
    remove_index :socialite_identites, [:user_id, :provider_id]
    remove_index :socialite_identites, [:provider, :unique_id]
    drop_table :socialite_identities
  end
end
