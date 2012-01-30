Feature: Request Password Reset
  In order to gain access to the portal even when I've forgotten my password
  As a user
  I want to be able to reset my password

  Background:
    Given a valid user exists in the database
      And I am not logged in
    When I go to the log-in page

  Scenario: Request a valid password reset (email address is found and 'first name' matches that User)
    When I click the reset password link
     And I fill in email
     And I fill in first name
     And I submit the form
    Then I should see the Password_Reset:new success body message
     And I should receive an email with my password reset link

  Scenario Outline: Request an invalid password reset (one or more fields don't match)
    When I click the reset password link
     And I fill in email with '<email>'
     And I fill in first name with '<name>'
     And I submit the form
    Then I should be at the new password reset path
     And I should see the Password_Reset:new failure message
     And I should not receive an email

    Examples:
      | email                      | name           |
      | not.a.real.email@email.com | Test           |
      | test@test.com              | Incorrect Name |
      | test@test.com              |                |

  ## Fullfillment

  Scenario Outline: Fullfill Password Reset
    Given I request a password reset
    When I go to the URL from the password reset email
    Then I should see the Password_Reset:show instructions message
    When I fill in Password with '<password>'
     And I fill in Password Confirmation with '<password_confirmation>'
     And I submit the form
    Then the Password Reset should <expected_result>

    Examples:
      | password   | password_confirmation | expected_result |
      | aoeuidhtns | aoeuidhtns            | fail            |
      | aoe        | aoe                   | fail            |
      | aoe123     | aoe123                | fail            |
      | aoe123#    | aoe123                | fail            |
      | aoe123#    | aoe123#               | succeed         |

