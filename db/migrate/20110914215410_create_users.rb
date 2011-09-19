class CreateUsers < ActiveRecord::Migration
  def up
    create_table :socialite_users do |t|
      t.string :remember_token
      # Any additional fields here

      t.timestamps
    end
  end

  def down
    drop_table :socialite_users
  end
end
