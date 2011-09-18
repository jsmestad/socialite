class CreateIdentities < ActiveRecord::Migration
  def up
    create_table :identities do |t|
      t.string :type
      t.integer :user_id
      t.string :uid
      t.string :name
      t.string :login
      t.string :picture_url
      t.string :access_token
      t.string :access_token_secret
      # Any additional fields here

      t.timestamps
    end

    add_index :identities, :user_id
    add_index :identities, :type
  end

  def down
    remove_index :identities, :type
    remove_index :identities, :user_id
    drop_table :identities
  end
end
