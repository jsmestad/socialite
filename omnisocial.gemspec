lib = File.expand_path('../lib/', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'omnisocial/version'

Gem::Specification.new do |gem|
  gem.name          = 'omnisocial'
  gem.version       = Omnisocial::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Tim Riley']
  gem.email         = 'tim@openmonkey.com'
  gem.homepage      = 'http://github.com/icelab/omnisocial'
  gem.summary       = 'Twitter and Facebook logins for your Rails application.'
  gem.description   = 'Twitter and Facebook logins for your Rails application.'

  # gem.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  gem.files = `git ls-files`.split("\n")

  gem.add_dependency 'rails', '~> 3.1.0'
  gem.add_dependency 'oa-core', '~> 0.3.0.rc3'
  gem.add_dependency 'oa-oauth', '~> 0.3.0.rc3'

  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rspec-rails', '~> 2.6.1'
  gem.add_development_dependency 'capybara', '~> 1.1.1'
  gem.add_development_dependency 'cucumber-rails', '~> 1.0.4'
  gem.add_development_dependency 'selenium-webdriver', '>= 2.4.0'
  gem.add_development_dependency 'launchy', '~> 2.0.5'
end
