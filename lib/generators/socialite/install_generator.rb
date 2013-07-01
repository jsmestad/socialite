require 'rails/generators'

module Socialite
  module Generators
    class InstallGenerator < ::Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../templates", __FILE__)

      desc 'Creates a socialite initializer'

      attr_reader :user_class_name, :identity_class_name, :use_omniauth_identity

      def copy_initializer
        @user_class_name     = Socialite.user_class_name     = ask_about_user_model
        @identity_class_name = Socialite.identity_class_name = ask_about_identity_model

        if use_omniauth_identity?
          gem('omniauth-identity')
          gem('bcrypt-ruby', '>=3')
        end

        generate('socialite:entities', "#{@user_class_name} #{@identity_class_name}")

        template 'socialite.rb.tt', 'config/initializers/socialite.rb'
      end

      private
      def use_omniauth_identity?
        return true if Rails.env.test?
        return @use_omniauth_identity if defined?(@use_omniauth_identity)
        if yes? <<-TXT
Would you like to use Omniauth-Identity?
Omniauth-Identity provides a database backed email/password in addition to the usual social logins.
TXT
          @use_omniauth_identity = true
        else
          @use_omniauth_identity = false
        end
      end

      def ask_about_user_model
        return Socialite.user_class_name if Rails.env.test?
        if user_model_exists?
          if yes?("Would you like to use the #{Socialite.user_class_name} model?")
            Socialite.user_class_name
          else
            ask("What model name would you like to use as the user Model: ").classify
          end
        else
          name = ask("What model name would you like to use as the user model (#{Socialite.user_class_name} is default): ")
          name.blank? ? Socialite.user_class_name : name.classify
        end
      end

      def ask_about_identity_model
        return Socialite.identity_class_name if Rails.env.test?
        if identity_model_exists?
          if yes?("Would you like to use the #{Socialite.identity_class_name} model? This model is used to store the individual identities of a given user.")
            Socialite.identity_class_name
          else
            ask("What model name would you like to use as the user Model: ").classify
          end
        else
          name = ask("What model name would you like to use as the identity model (#{Socialite.identity_class_name} is default): ")
          name.blank? ? Socialite.identity_class_name : name.classify
        end
      end

      def user_model_exists?(model=Socialite.user_class_name)
        return @user_model_exists if defined?(@user_model_exists)
        @user_model_exists = class_exists?(model)
      end

      def identity_model_exists?(model=Socialite.identity_class_name)
        return @identity_model_exists if defined?(@identity_model_exists)
        @identity_model_exists = class_exists?(model)
      end

      def class_exists?(model)
        !!model.classify.constantize
      rescue NameError
        false
      end
    end
  end
end
