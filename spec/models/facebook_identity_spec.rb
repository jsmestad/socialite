require 'spec_helper'

module Socialite
  describe FacebookIdentity do
    before(:each) { FactoryGirl.create(:facebook_identity) }
    it_behaves_like 'identity'

    describe '.api_connection' do
      subject { FacebookIdentity.api_connection }

      it 'returns a connection to the Facebook Graph API' do
        subject.should be_a(Koala::Facebook::API)
      end

      it 'defaults to not using an access token' do
        subject.access_token.should be_nil
      end

      context 'with specified access token' do
        let(:fake_token) { '1234567890' }
        subject { FacebookIdentity.api_connection(fake_token) }

        it 'does not use an access_token unless specified' do
          subject.should be_a(Koala::Facebook::API)
          subject.access_token.should eql(fake_token)
        end
      end
    end
  end

  describe FacebookIdentity, 'access methods' do
    subject { FactoryGirl.build(:facebook_identity) }

    it { should respond_to(:account_url) }
    it { should respond_to(:api) }
    it { should respond_to(:api_connection) }
    it { should respond_to(:checkins) }
    it { should respond_to(:friends) }
    it { should respond_to(:picture) }
    it { should respond_to(:info) }
  end
end
