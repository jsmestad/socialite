module Socialite
  shared_examples 'identity' do
    it { should belong_to(:user) }

    it { should have_db_column(:uid).of_type(:string) }
    it { should have_db_column(:provider).of_type(:string) }
    it { should have_db_column(:auth_hash) }

    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }

    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
    it { should validate_uniqueness_of(:provider).scoped_to(:"#{user_class.table_name.singularize}_id").case_insensitive }

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
        subject { identity_class.find_or_create_from_omniauth(auth_hash) }

        it { should be_a(identity_class) }
        its(:persisted?) { should be_false }

        context 'existing identity' do
          let(:user) { FactoryGirl.create(:linked_user) }
          let(:identity) { user.identities.first }
          let(:auth_hash) { identity.auth_hash.merge('provider' => identity.provider, 'uid' => identity.uid) }

          subject { identity_class.find_or_create_from_omniauth(auth_hash) }

          before do
            user.identities.count.should_not eql(0)
            identity.user.should be_present
          end

          its(:persisted?) { should be_true }
          its(:user) { should be_a(user_class) }
          its(:user) { should eql(user) }
        end
      end
    end
  end
end
