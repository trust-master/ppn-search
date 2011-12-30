Feature: Authentication
  In order to protect the contents of the portal
  As the company
  We want to provide authentication by means of email address and password

  Background:
    Given a valid user exists in the database
      And I am not logged in
    When I go to the log-in page

  Scenario: User with correct credentials attempts log-in
    When I enter a valid email and password
    Then I should see the login success message

  Scenario: User with an incorrect email attempts log-in
    When I enter an invalid email and any password
    Then I should see the login failure message

  Scenario: User with correct email but incorrect password attempts log-in
    When I enter an valid email and invalid password
    Then I should see the login failure message
