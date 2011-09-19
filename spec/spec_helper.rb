# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'
require 'rspec/rails'

# Should matchers
require 'shoulda/matchers'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load factories
require 'factory_girl'
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each { |f| require f }

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path('../dummy/db/migrate/', __FILE__)

RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers

  config.use_transactional_fixtures = true
end
