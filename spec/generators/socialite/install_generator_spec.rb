require 'spec_helper'
require "generators/socialite/install_generator"

describe Socialite::Generators::InstallGenerator do
  destination File.expand_path("../../../../tmp", __FILE__)

  before(:each) do
    prepare_destination
    %w(config script).each do |dir|
      `ln -s #{Rails.root + dir} #{destination_root}`
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
    gen.should_receive :run_other_generators
    capture(:stdout) { gen.invoke_all }
  end

   # custom matchers make it easy to verify what the generator creates
  describe 'the generated files' do
    before do
      run_generator %w(install)
    end
    describe 'the spec' do
      # file - gives you the absolute path where the generator will create the file
      subject { file('config/initializers/socialite.rb') }
       # should exist - verifies the file exists
      it { should exist }

      # should contain - verifies the file's contents
      it { should contain(/Socialite.setup do \|config\|/) }
    end
  end
end
