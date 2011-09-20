module Socialite
  FactoryGirl.define do
    factory :user, :class => Socialite::User do
      # Something here
    end

    factory :linked_user, :parent => :user do

      after_build do |user|
        user.facebook_identities = [
          FactoryGirl.build(:facebook_identity, :provider => 'facebook'),
        ]
        user.twitter_identities = [
          FactoryGirl.build(:twitter_identity, :provider => 'twitter')
        ]
      end
    end
  end
end
