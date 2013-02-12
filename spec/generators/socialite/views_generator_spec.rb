require 'spec_helper'
require "generators/socialite/views_generator"

describe Socialite::Generators::ViewsGenerator do
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
    gen = generator %w(views)
    gen.should_receive :copy_views
    capture(:stdout) { gen.invoke_all }
  end
end
