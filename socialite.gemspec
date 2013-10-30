$:.push File.expand_path("../lib", __FILE__)

# Maintain your s's version:
require 'socialite/version'

Gem::Specification.new do |s|
  s.name          = 'socialite'
  s.version       = Socialite::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Justin Smestad']
  s.email         = 'justin.smestad@gmail.com'
  s.homepage      = 'http://github.com/jsmestad/socialite'
  s.summary       = 'Rails engine supporting multiple auth providers per user.'
  s.description   = 'Rails engine supporting multiple auth providers per user.'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rails', "~> 4.0"
  s.add_runtime_dependency 'sass-rails'
  s.add_runtime_dependency 'haml'
  s.add_runtime_dependency 'omniauth', '~> 1.1.4'
  s.add_runtime_dependency 'omniauth-identity'
  s.add_runtime_dependency 'bcrypt-ruby', '~> 3.1.2'

  # Optional Gem Dependencies

  s.add_development_dependency 'simple_form', '~> 3.0'

  # Various OmniAuth gems we test against
  s.add_development_dependency 'omniauth-facebook'
  s.add_development_dependency 'omniauth-twitter'

  # Test Dependencies
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'capybara', '>= 2.0.2'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ammeter'
end
