require 'spec_helper'

feature "Registration" do
  background do
    Socialite.setup do |config|
      config.provider :identity,
        :model => Socialite.user_class,
        :fields => [:email],
        :on_failed_registration => Socialite::UsersController.action(:new)
    end

    FactoryGirl.create(:identity_user, :email => 'user@example.com', :password => 'caplin')
  end

  scenario "Signing in with correct credentials" do
    visit '/login'
    # within("#session") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'caplin'
    # end
    click_button 'Sign in'
    page.should have_content 'Signed in!'
  end

  scenario "Signing in as invalid user" do
    visit '/login'
    # within("#session") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'bogus'
    # end
    click_button 'Sign in'
    page.should have_content 'Authentication failed, please try again.'
  end
end
