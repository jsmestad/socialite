require 'spec_helper'

# FIXME Relies on spec/dummy/config/initializers/omniauth-facebook.rb or you get
# stack/routing/middleware issues.
#
feature "Facebook Registration", :omniauth => true do
  background do
    FactoryGirl.create(:linked_user)
  end

  scenario "Signing up with Facebook" do
    visit '/auth/facebook'
    page.should have_text 'Welcome to the app!'
  end
end

