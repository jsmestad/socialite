FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'secret'
  end

  factory :linked_user, :parent => :user do
    after(:build) do |user|
      user.identities = [
        FactoryGirl.build(:identity, :provider => 'facebook'),
        FactoryGirl.build(:identity, :provider => 'twitter')
      ]
    end
  end

  factory :identity_user, :parent => :user do
    after(:create) do |user|
      user.identities = [
        FactoryGirl.build(:identity, :provider => 'identity', :uid => user.uid)
      ]
    end
  end
end
