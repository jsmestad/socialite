class CreateSocialiteIdentities < ActiveRecord::Migration
  def up
    create_table :socialite_identities do |t|
      t.string :uid, :provider
      t.text :auth_hash
      t.integer :socialite_user_id
      t.timestamps
    end

    add_index :socialite_identities,
      :socialite_user_id

    # Restrict each user to one identity per provider, to disable comment out.
    add_index :socialite_identities,
      [:socialite_user_id, :provider], :unique => true

    # Database constraint to ensure uniqueness of UIDs (scoped to provider)
    add_index :socialite_identities,
      [:provider, :uid], :unique => true
  end

  def down
    drop_table :socialite_identities
  end
end
