# Steps related to authentication can be found below
#
Given /^I am an authenticated user$/ do
  Given %{I am a user}
  Given %{I am authenticated}
end

Given /^I am authenticated with facebook$/ do
  Given %{I go to the home page}
  And %{I click "Sign in"}
  And %{I click "Sign in with Facebook"}

  Then %{I should be authenticated}
  And %{I should have a Facebook Identity}
end

Given /^I am not authenticated$/ do
  # do nothing
end

Then /^I should (not|)\s?be (?:logged in|authenticated)$/ do |negative|
  if negative.present?
    # page.should_not have_content "Dashboard"
    page.should_not have_content "Sign out"
    page.should have_content "Sign in"
  else
    # page.should have_content "Dashboard"
    page.should have_content "Sign out"
    page.should_not have_content "Sign in"
  end
end
