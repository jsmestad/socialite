class CreateSocialite < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :name, :email
      t.string :password_digest
      t.boolean :placeholder_email
      t.timestamps
    end
    add_index :users, :email, :unique => true


    create_table :identities do |t|
      t.string :uid, :provider
      t.text :auth_hash
      t.integer :user_id
      t.timestamps
    end

    add_index :identities, :user_id

    # Restrict each user to one identity per provider, to disable comment out.
    add_index :identities, [:user_id, :provider], :unique => true

    # Database constraint to ensure uniqueness of UIDs (scoped to provider)
    add_index :identities, [:provider, :uid], :unique => true

  end
end
