require 'spec_helper'

# FIXME Relies on spec/dummy/config/initializers/omniauth-identity.rb or you get
# stack/routing/middleware issues.
#
feature "Identity Registration" do
  background do
    FactoryGirl.create(:identity_user, :email => 'user@example.com', :password => 'caplin')
  end

  scenario "Signing up with existing email" do
    visit '/signup'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'password', :with => 'caplin'
    fill_in 'password_confirmation', :with => 'caplin'
    click_button 'Sign Up'
    page.should have_css('.error')
    page.should have_button('Sign Up')
  end

  scenario "Signing up with valid email" do
    visit '/signup'
    fill_in 'Email', :with => 'diffuser@example.com'
    fill_in 'password', :with => 'secrets'
    fill_in 'password_confirmation', :with => 'secrets'
    click_button 'Sign Up'
    page.should have_text 'Welcome to the app!'
    page.should have_no_css('.error')
    page.should have_no_button('Sign Up')
  end
end
