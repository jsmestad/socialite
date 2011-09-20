require 'spec_helper'

module Socialite
  describe User do
    let(:linked_user) { FactoryGirl.create(:linked_user) }

    it { should have_many(:facebook_identities).dependent(:destroy) }
    it { should have_many(:twitter_identities).dependent(:destroy) }

    context 'with associated identities' do
      subject { linked_user }

      before do
        subject.facebook_identities.count.should eql(1)
        subject.twitter_identities.count.should eql(1)
      end

      its(:facebook) { should be_a(Socialite::FacebookIdentity) }
      its(:twitter) { should be_a(Socialite::TwitterIdentity) }
    end
  end
end
