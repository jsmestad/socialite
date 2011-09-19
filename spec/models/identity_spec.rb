require 'spec_helper'

describe Socialite::Identity do
  before(:each) { FactoryGirl.create(:identity) }

  it { should belong_to(:user) }

  it { should have_db_column(:unique_id) }
  it { should have_db_column(:provider) }
  it { should have_db_column(:auth_hash) }

  it { should validate_presence_of(:unique_id) }
  it { should validate_presence_of(:provider) }

  it { should validate_uniqueness_of(:unique_id).scoped_to(:provider) }
  it { should validate_uniqueness_of(:provider).scoped_to(:user_id).case_insensitive }
end
