@omniauth
Feature: Facebook Identity Management

  Background:
    Given I am authenticated with facebook

  Scenario: Updating account permissions for Facebook

  Scenario: Unauthorizing Facebook identity from user
    When I am on the home page
      And I click "User Profile"
      And I click "Unlink Facebook"
    Then I should not be logged in
      And I should see a flash message
