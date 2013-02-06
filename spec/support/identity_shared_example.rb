module Socialite
  shared_examples 'identity' do
    it { should belong_to(:user) }

    it { should have_db_column(:uid) }
    it { should have_db_column(:provider) }
    it { should have_db_column(:auth_hash) }

    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }

    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
    it { should validate_uniqueness_of(:provider).scoped_to("#{user_class.table_name.singularize}_id").case_insensitive }

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
        subject { identity_class.find_or_initialize_by_omniauth(auth_hash) }

        it { should be_a(identity_class) }
        its(:persisted?) { should be_false }

        context 'existing identity' do
          let(:user) { FactoryGirl.create(:linked_user) }
          let(:identity) { user.identities.first }
          let(:auth_hash) { identity.auth_hash.merge('provider' => identity.provider, 'uid' => identity.uid) }

          subject { identity_class.find_or_initialize_by_omniauth(auth_hash) }

          before do
            user.identities.count.should > 0
            identity.user.should be_present
          end

          its(:persisted?) { should be_true }
          its(:user) { should be_a(user_class) }
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

  # shared_examples 'facebook api' do
    # it { should respond_to(:account_url) }
    # it { should respond_to(:api) }
    # it { should respond_to(:api_connection) }
    # it { should respond_to(:checkins) }
    # it { should respond_to(:friends) }
    # it { should respond_to(:picture) }
    # it { should respond_to(:info) }
  # end
end
