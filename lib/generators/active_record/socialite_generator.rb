require 'rails/generators/migration'

module ActiveRecord
  module Generators
    class SocialiteGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      class_option :users_table,
        :default => 'socialite_users',
        :type => :string
      class_option :identity_table,
        :default => 'socialite_identity',
        :type => :string

      desc "add the migrations needed for socialite"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "users.rb.erb", "db/migrate/create_socialite_users.rb"
        migration_template "identity.rb.erb", "db/migrate/create_socialite_identity.rb"
      end
    end
  end
end
