require 'spec_helper'

describe User do
  let(:linked_user) { FactoryGirl.create(:linked_user) }

  it { should have_many(:identities).dependent(:destroy) }

  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:password_digest).of_type(:string) }

  it { should have_db_index(:email).unique(true) }

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
