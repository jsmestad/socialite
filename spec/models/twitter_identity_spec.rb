require 'spec_helper'

module Socialite
  describe TwitterIdentity do
    before(:each) { FactoryGirl.create(:twitter_identity) }
    it_behaves_like 'identity'
  end
end
