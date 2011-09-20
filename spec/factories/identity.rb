FactoryGirl.define do
  trait :identity do
    sequence(:unique_id, 1000) { |n| "abcdef#{n}" }
    association :user, :factory => :user, :method => :build
  end

  factory :facebook_identity, :traits => [:identity], :class => Socialite::FacebookIdentity do
    provider 'facebook'
  end

  factory :twitter_identity, :traits => [:identity], :class => Socialite::TwitterIdentity do
    provider 'twitter'
  end
end
