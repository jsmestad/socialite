module Socialite
  FactoryGirl.define do
    factory :user, :class => Socialite::User do
      # Something here
    end

    factory :linked_user, :parent => :user do
      after_build do |user|
        user.identities = [
          FactoryGirl.build(:identity, :provider => 'facebook'),
          FactoryGirl.build(:identity, :provider => 'twitter')
        ]
      end
    end
  end
end
