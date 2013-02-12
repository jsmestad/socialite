require 'spec_helper'

# FIXME Relies on spec/dummy/config/initializers/omniauth-identity.rb or you get
# stack/routing/middleware issues.
#
feature "Identity Login" do
  background do
    FactoryGirl.create(:identity_user, :email => 'user@example.com', :password => 'caplin')
  end

  scenario "Signing in with correct credentials" do
    visit '/login'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'caplin'
    click_button 'Sign in'
    page.should have_content 'Signed in!'
  end

  scenario "Signing in as invalid user" do
    visit '/login'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'bogus'
    click_button 'Sign in'
    page.should have_content 'Authentication failed, please try again.'
  end
end
