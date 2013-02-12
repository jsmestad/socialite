require 'spec_helper'

describe Identity do
  let!(:identity) { FactoryGirl.create(:identity) }

  it_behaves_like 'identity'
end
