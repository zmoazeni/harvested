@clean
Feature: Managing People

  Scenario: Adding and Removing a User
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a user with the following:
    | first_name            | Edgar          |
    | last_name             | Ruth           |
    | email                 | edgar@ruth.com |
    | password              | mypassword     |
    | password_confirmation | mypassword     |
    | timezone              | cst            |
    | admin                 | false          |
    | telephone             | 444-4444       |
    Then there should be a user "edgar@ruth.com"
    When I update the user "edgar@ruth.com" with the following:
    | first_name | Jonah |
    | timezone   | pst   |
    Then the user "edgar@ruth.com" should have the following attributes:
    | first_name | Jonah                      |
    | timezone   | Pacific Time (US & Canada) |
    When I delete the user "edgar@ruth.com"
    Then there should not be a user "edgar@ruth.com"
    
  Scenario: Activating and Deactivating a User
    Given I am using the credentials from "./support/harvest_credentials.yml"
    Then I create a user with the following:
    | first_name            | Simon           |
    | last_name             | Steel           |
    | email                 | simon@steel.com |
    | password              | mypassword      |
    | password_confirmation | mypassword      |
    | timezone              | cst             |
    | admin                 | false           |
    | telephone             | 444-4444        |
    Then the user "simon@steel.com" should be activated
    When I deactivate the user "simon@steel.com"
    Then the user "simon@steel.com" should be deactivated
    When I activate the user "simon@steel.com"
    Then the user "simon@steel.com" should be activated
    Then I delete the user "simon@steel.com"
  
  Scenario: Resetting a User's password
    Given I am using the credentials from "./support/harvest_credentials.yml"
    Then I create a user with the following:
    | first_name            | Edgar          |
    | last_name             | Ruth           |
    | email                 | edgar@ruth.com |
    | password              | mypassword     |
    | password_confirmation | mypassword     |
    | timezone              | cst            |
    | admin                 | false          |
    | telephone             | 444-4444       |
    Then there should be a user "edgar@ruth.com"
    Then I reset the password of "edgar@ruth.com"
