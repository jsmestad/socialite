require 'spec_helper'

feature "Registration" do
  background do
    Socialite.setup do |config|
      config.provider :identity,
        :model => User,
        :fields => [:email],
        :on_failed_registration => Socialite::UsersController.action(:new)
    end

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
