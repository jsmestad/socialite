require 'spec_helper'

describe User, :omniauth => true do
  let(:linked_user) { FactoryGirl.create(:linked_user) }

  it { should have_many(:identities).dependent(:destroy) }

  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:password_digest).of_type(:string) }

  it { should have_db_index(:email).unique(true) }

  it { should validate_uniqueness_of(:email).case_insensitive }

  context 'existing users' do
    let!(:twitter_user)  { FactoryGirl.create(:user, email: 'johndoe@twitter.com') }

    describe 'finding existing instead of creating additional' do
      subject { described_class.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

      its(:email) { should eql('johndoe@twitter.com') }

      it 'retrieved the record; and did not create an additional one' do
        lambda { subject }.should_not change(described_class, :count)
      end
    end

    describe 'creating user if finder fails' do
      subject { described_class.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:facebook]) }

      it 'returns a new record' do
        lambda { subject }.should change(described_class, :count).by(1)
      end
    end
  end

  context 'with associated identities' do
    subject { linked_user }

    before do
      subject.identities.count.should eql(2)
    end

    its('identities.count') { should eql(2) }

    its(:facebook_identity) { should be_a(identity_class) }

    its(:twitter_identity) { should be_a(identity_class) }
  end
end
