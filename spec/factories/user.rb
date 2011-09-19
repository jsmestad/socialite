FactoryGirl.define do
  factory :user, :class => Socialite::User do
    # Something here
  end

  factory :linked_user, :parent => :user do
    after_build do |user|
      user.identities = [
        FactoryGirl.build(:associated_identity, :provider => 'facebook'),
        FactoryGirl.build(:associated_identity, :provider => 'twitter')
      ]
    end
  end
end
