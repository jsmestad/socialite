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
  # s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "jquery-rails"

  s.add_dependency 'sass-rails',  '~> 3.2.0'
  s.add_dependency 'simple_form'
  s.add_dependency 'haml'
  s.add_dependency 'omniauth',    '~> 1.1.0'
  s.add_dependency 'omniauth-identity'
  s.add_dependency 'omniauth-facebook'
  s.add_dependency 'omniauth-twitter'
  # s.add_dependency 'koala',       '~> 1.2.0beta4'
  # s.add_dependency 'grackle',     '~> 0.1.10'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'ammeter'

  # s.add_development_dependency 'cucumber-rails', '~> 1.0.6'
  # s.add_development_dependency 'database_cleaner', '>= 0.6.7'
  # s.add_development_dependency 'selenium-webdriver', '>= 2.4.0'
  # s.add_development_dependency 'launchy', '~> 2.0.5'
end
