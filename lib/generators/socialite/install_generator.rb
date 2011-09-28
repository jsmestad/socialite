require 'rails/generators'
require 'rails/generators/migration'

module Socialite
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Generates the socialite initializer'

      def self.source_root
        File.join(File.dirname(__FILE__), 'templates')
      end

      def copy_initializer
        template 'socialite.rb', 'config/initializers/socialite.rb'
      end

    end
  end
end
