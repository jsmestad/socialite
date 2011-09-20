require 'spec_helper'

module Socialite
  describe FacebookIdentity do
    before(:each) { FactoryGirl.create(:facebook_identity) }
    it_behaves_like 'identity'
  end
end
