require 'spec_helper'

module Socialite
  describe Identity do
    let!(:identity) { FactoryGirl.create(:identity) }

    it_behaves_like 'identity'
  end
end
