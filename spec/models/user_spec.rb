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

  describe User, 'create or update by provider' do
    before do
      Socialite.const_defined?('FacebookIdentity').should be_true
      Socialite.const_defined?('TwitterIdentity').should be_true
    end

    let(:auth_hash) do
      {
        'provider' => 'facebook',
        'uid' => '555',
        'credentials' => {
          'token' => '123648493',
          'secret' => '12477388272'
        }
      }
    end

    describe 'facebook' do
      let(:facebook_identity) { User.create_or_update_by_identity('facebook', auth_hash) }
      subject { facebook_identity }

      it { should be_a(User) }
      its(:persisted?) { should be_true }
      its(:facebook) { should be_a(FacebookIdentity) }
    end

    describe 'twitter' do
      let(:twitter_identity) { User.create_or_update_by_identity('twitter', auth_hash.merge('provider' => 'twitter')) }
      subject { twitter_identity }

      it { should be_a(User) }
      its(:persisted?) { should be_true }
      its(:twitter) { should be_a(TwitterIdentity) }
    end
  end
end
