FactoryGirl.define do
  factory :identity, :class => Socialite::Identity do
    unique_id 'abc123'
    provider 'twitter'
    association :user, :factory => :user, :method => :build
  end

  factory :associated_identity, :parent => :identity do
    sequence(:unique_id, 1000) { |n| "abcdef#{n}" }
  end
end
