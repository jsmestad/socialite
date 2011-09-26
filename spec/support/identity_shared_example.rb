module Socialite
  shared_examples 'identity' do
    it { should belong_to(:user) }

    it { should have_db_column(:unique_id) }
    it { should have_db_column(:provider) }
    it { should have_db_column(:auth_hash) }

    it { should validate_presence_of(:unique_id) }
    it { should validate_presence_of(:provider) }

    it { should validate_uniqueness_of(:unique_id).scoped_to(:provider) }
    it { should validate_uniqueness_of(:provider).scoped_to(:user_id).case_insensitive }

    describe '.find_or_initialize_by_oauth' do
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
        # let(:fb_identity) { }
        subject { Identity.find_or_initialize_by_oauth(auth_hash) }

        it { should be_a(Identity) }
        its(:persisted?) { should be_false }

        context 'existing identity' do
          let(:user) { FactoryGirl.create(:linked_user) }
          let(:identity) { user.identities.first }
          let(:auth_hash) { identity.auth_hash.merge('provider' => identity.provider, 'uid' => identity.unique_id) }
          subject { Identity.find_or_initialize_by_oauth(auth_hash) }
          before { user.identities.count.should > 0; identity.user.should be_present }

          its(:persisted?) { should be_true }
          its(:user) { should be_a(User) }
          its(:user) { should eql(user) }
        end
      end

      # describe 'twitter' do
      #   let(:twitter_identity) { subject.find_or_initialize_by_oauth(auth_hash.merge('provider' => 'twitter')) }
      #   subject { twitter_identity }

      #   it { should be_a(Identity) }
      #   its(:persisted?) { should be_true }
      #   its(:user) { should be_a(User) }
      # end
    end
  end

  shared_examples 'facebook api' do
    it { should respond_to(:account_url) }
    it { should respond_to(:api) }
    it { should respond_to(:api_connection) }
    it { should respond_to(:checkins) }
    it { should respond_to(:friends) }
    it { should respond_to(:picture) }
    it { should respond_to(:info) }
  end
end
