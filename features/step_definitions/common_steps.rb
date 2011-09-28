# Don't like the when I follow, so map click
# to the follow web step from capybara.
When /^(?:|I )click "([^"]*)"$/ do |button|
  When %{follow "#{button}"}
end

Then /^I should (not|)\s?see a flash message$/ do |negative|
  if negative.present?
    page.should_not have_css "div.flash"
  else
    page.should have_css "div.flash"
  end
end
