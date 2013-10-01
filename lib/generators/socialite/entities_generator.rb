require 'rails/generators'

module Socialite
  module Generators
    class EntitiesGenerator < ::Rails::Generators::Base #:nodoc:
      include ::Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc 'Creates the required User mode and Migration for Socialite'

      argument :user_model_name
      argument :identity_model_name

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def generate_socialite_files
        if !user_class_exists? || !identity_class_exists?
          migration_template "models/migration.rb.erb", "db/migrate/create_socialite.rb"
        end

        template("models/user.rb.erb",     "app/models/#{singular_user_name}.rb")     unless user_class_exists?
        template("models/identity.rb.erb", "app/models/#{singular_identity_name}.rb") unless identity_class_exists?
      end

      private
      def user_class_exists?
        return @user_class_exists if defined?(@user_class_exists)
        @user_class_exists = class_exists?(user_class_name)
      end

      def identity_class_exists?
        return @identity_class_exists if defined?(@identity_class_exists)
        @identity_class_exists = class_exists?(identity_class_name)
      end

      def class_exists?(type)
        type.constantize
      rescue NameError
        false 
      end

      def user_class_name
        @user_class_name ||= user_model_name.singularize.classify
      end

      def singular_user_name
        @singular_user_name ||= user_class_name.underscore.singularize
      end

      def plural_user_name
        @plural_user_name ||= singular_user_name.pluralize
      end

      def identity_class_name
        @identity_class_name ||= identity_model_name.singularize.classify
      end

      def singular_identity_name
        @singular_identity_name ||= identity_class_name.underscore.singularize
      end

      def plural_identity_name
        @plural_identity_name ||= singular_identity_name.pluralize
      end
    end
  end
end
