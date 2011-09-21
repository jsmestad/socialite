@wip
Feature: Facebook Signup

  Scenario: Registration with Facebook
    Given I am an unauthenticated user
    When I go to the new user page
    And I press "Sign In with Facebook"
    Then I should be logged in
      And I should see a flash message
