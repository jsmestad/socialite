require 'spec_helper'
require "generators/socialite/install_generator"

describe Socialite::Generators::InstallGenerator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:each) do
    prepare_destination

    %w(config script Gemfile).each do |dir|
      `ln -s #{Rails.root.join(dir)} #{destination_root}`
    end
  end

  after(:each) do
    unless example.exception
      prepare_destination
    end
  end

  # using mocks to ensure proper methods are called
  # invoke_all - will call all the tasks in the generator
  it 'should run all tasks in the generator' do
    gen = generator %w(install)
    gen.should_receive :copy_initializer
    capture(:stdout) { gen.invoke_all }
  end

  # custom matchers make it easy to verify what the generator creates
  describe 'the generated files' do
    before do
      run_generator %w(socialite:install)
    end

    describe 'the configuration file' do
      # file - gives you the absolute path where the generator will create the file
      subject {file('config/initializers/socialite.rb') }
       # should exist - verifies the file exists
      it { should exist }

      # should contain - verifies the file's contents
      it { should contain(/Socialite.setup do \|config\|/) }
    end

    describe 'the routes file' do
      subject { file('config/routes.rb') }
      it { should contain(/mount Socialite::Engine, :at => '\/socialite'/) }
    end

    describe "gems" do
      subject { file('Gemfile') }
      it { should contain 'gem "bcrypt-ruby"' }
      it { should contain 'gem "omniauth-identity"'}
    end

    describe "user model" do
      subject { file("app/models/user.rb") }
      it { should exist }

    end

    describe "identity model" do
      subject { file("app/models/identity.rb") }
      it { should exist }

    end
  end
end
