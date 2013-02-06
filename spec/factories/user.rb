FactoryGirl.define do
  factory :user, :class => 'User' do
    # Something here
  end

  factory :linked_user, :class => 'User', :parent => :user do
    after_build do |user|
      user.identities = [
        FactoryGirl.build(:identity, :provider => 'facebook'),
        FactoryGirl.build(:identity, :provider => 'twitter')
      ]
    end
  end
end
