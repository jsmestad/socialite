@omniauth
Feature: Facebook Signup

  Scenario: Registration with Facebook
    Given I am not authenticated
    When I go to the home page
      And I click "Sign in"
      And I click "Sign in with Facebook"
    Then I should be logged in
      And I should see a flash message
