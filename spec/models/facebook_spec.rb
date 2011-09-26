require 'spec_helper'

module Socialite
  describe FacebookIdentity do
    subject { FactoryGirl.build(:facebook_identity) }
    it_behaves_like 'facebook api'

    describe '.api_connection' do
      subject { Socialite::FacebookIdentity.api_connection }

      it { should be_a(Koala::Facebook::API) }

      it 'defaults to not using an access token' do
        subject.access_token.should be_nil
      end

      context 'with specified access token' do
        let!(:fake_token) { '1234567890' }
        subject { Socialite::FacebookIdentity.api_connection(fake_token) }

        it 'does not use an access_token unless specified' do
          subject.should be_a(Koala::Facebook::API)
          subject.access_token.should eql(fake_token)
        end
      end
    end
  end
end
