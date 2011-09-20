$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'socialite/version'

Gem::Specification.new do |gem|
  gem.name          = 'socialite'
  gem.version       = Socialite::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Justin Smestad']
  gem.email         = 'justin.smestad@gmail.com'
  gem.homepage      = 'http://github.com/jsmestad/socialite'
  gem.summary       = 'Rails engine supporting multiple auth providers per user.'
  gem.description   = 'Rails engine supporting multiple auth providers per user.'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails',       '~> 3.1.0'
  gem.add_dependency 'bcrypt-ruby', '~> 3.0.0'
  gem.add_dependency 'oa-core',     '~> 0.3.0.rc3'
  gem.add_dependency 'oa-oauth',    '~> 0.3.0.rc3'
  gem.add_dependency 'koala',       '~> 1.2.0beta3'

  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rspec-rails', '~> 2.6.1'
  gem.add_development_dependency 'factory_girl', '~> 2.1.0'
  gem.add_development_dependency 'shoulda-matchers'
  gem.add_development_dependency 'capybara', '~> 1.1.1'
  gem.add_development_dependency 'cucumber-rails', '~> 1.0.4'
  gem.add_development_dependency 'selenium-webdriver', '>= 2.4.0'
  gem.add_development_dependency 'launchy', '~> 2.0.5'
end
