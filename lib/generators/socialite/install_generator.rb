require 'rails/generators'

module Socialite
  module Generators
    class InstallGenerator < ::Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../templates", __FILE__)

      desc 'Creates a socialite initializer'
      def copy_initializer
        template 'socialite.rb', 'config/initializers/socialite.rb'
      end

      def mount_engine
        puts "Mounting Socialite::Engine at \"/socialite\" in config/routes.rb..."
        insert_into_file("config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{
  # This line mounts Socialite's routes at /socialite by default.
  # This means, any requests to the /socialite URL of your application will go
  # to Socialite::SessionsController#new. If you would like to change where
  # this extension is mounted, simply change the :at option to something
  # different.
  #
  # We ask that you don't use the :as option here, as Socialite relies on it
  # being the default of "socialite"
  mount Socialite::Engine, :at => '/socialite'

}
        end

      end
    end
  end
end
