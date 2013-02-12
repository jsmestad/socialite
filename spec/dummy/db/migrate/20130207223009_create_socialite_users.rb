class CreateSocialiteUsers < ActiveRecord::Migration
  def up
    create_table :socialite_users do |t|
      t.string :name, :email
      t.string :password_digest # set :null => false to enforce identity, requires 'bcrypt-ruby' in your Gemfile.
      t.timestamps
    end

    # Enforce only every email must be unique
    add_index :socialite_users, :email, :unique => true
  end

  def down
    drop_table :socialite_users
  end
end
