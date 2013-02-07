require 'rails/generators'

module Socialite
  module Generators
    class ViewsGenerator < ::Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/views/socialite", __FILE__)
      desc "Used to copy socialite's views to your application's views."

      def copy_views
        view_directory :identities
        view_directory :sessions
        view_directory :users
      end

    protected

      def view_directory(name)
        directory name.to_s, "app/views/socialite/#{name}"
      end
    end
  end
end
