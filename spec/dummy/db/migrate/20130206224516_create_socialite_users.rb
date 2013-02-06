class CreateSocialiteUsers < ActiveRecord::Migration
  def up
    create_table :socialite_users do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :socialite_users
  end
end
