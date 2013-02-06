require 'rails/generators'

module Socialite
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc 'Creates a socialite initializer'
      def copy_initializer
        template 'socialite.rb', 'config/initializers/socialite.rb'
      end

      # def add_opro_routes
        # socialite_routes = "mount_socialite_oauth"
        # route socialite_routes
      # end
    end
  end
end
