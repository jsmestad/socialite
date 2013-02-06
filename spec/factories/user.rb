FactoryGirl.define do
  factory :user do
    # Something here
  end

  factory :linked_user, :parent => :user do
    after(:build) do |user|
      user.identities = [
        FactoryGirl.build(:identity, :provider => 'facebook'),
        FactoryGirl.build(:identity, :provider => 'twitter')
      ]
    end
  end
end
