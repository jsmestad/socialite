require 'spec_helper'

describe Socialite::User do
  let(:linked_user) { FactoryGirl.create(:linked_user) }

  it { should have_many(:identities).dependent(:destroy) }

  its(:facebook_identities) { should be_a(Array) }
  its(:twitter_identities) { should be_a(Array) }

  context 'with associated identities' do
    subject { linked_user }

    its('identities.count') { should eql(2) }
    its(:facebook) { should be_a(Socialite::Identity) }
    its(:twitter) { should be_a(Socialite::Identity) }
  end
end
