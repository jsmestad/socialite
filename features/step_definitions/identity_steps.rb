Then /^I should have a Facebook Identity$/ do
  user = Socialite::User.first
  user.identities.count.should > 0
  user.facebook_identity.should_not be_nil
end
