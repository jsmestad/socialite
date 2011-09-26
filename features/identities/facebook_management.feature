@wip
Feature: Facebook Identity Management

  Scenario: Linking existing user with Facebook
    Given I am an authenticated user
    When I go to the edit identities page
      And I press on "Sign In with Facebook"
    Then I should be logged in
      And I should see a flash message

  Scenario: Updating account permissions for Facebook

  Scenario: Unauthorizing Facebook identity from user
    Given I am an authenticated user
      And I have linked my Facebook identity
    When I go to the edit identities page
      And I click "Unlink Facebook"
    Then I should not be logged in
      And I should see a flash message
