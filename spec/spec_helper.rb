# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Testing Generators
require 'ammeter/init'
require 'ffaker'
require 'factory_girl_rails'

# Should matchers
require 'shoulda/matchers'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Run migrations if present
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

RSpec.configure do |config|
  config.include RSpec::Matchers
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  # http://stackoverflow.com/a/12978795
  config.include Capybara::DSL, type: :request
  config.include Socialite::Engine.routes.url_helpers
end

def identity_class
  Socialite.identity_class
end

def user_class
  Socialite.user_class
end
