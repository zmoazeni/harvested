@clean
Feature: Managing People

  Scenario: Adding and Removing a Person
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a person with the following:
    | first_name            | Edgar          |
    | last_name             | Ruth           |
    | email                 | edgar@ruth.com |
    | password              | mypassword     |
    | password_confirmation | mypassword     |
    | timezone              | cst            |
    | admin                 | false          |
    | telephone             | 444-4444       |
    Then there should be a person "edgar@ruth.com"
    When I update the person "edgar@ruth.com" with the following:
    | first_name | Jonah |
    | timezone   | pst   |
    Then the person "edgar@ruth.com" should have the following attributes:
    | first_name | Jonah                      |
    | timezone   | Pacific Time (US & Canada) |
    When I delete the person "edgar@ruth.com"
    Then there should not be a person "edgar@ruth.com"
    
  @wip
  Scenario: Activating and Deactivating a Person
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And I use local person API
    Then I create a person with the following:
    | first_name            | Edgar          |
    | last_name             | Ruth           |
    | email                 | edgar@ruth.com |
    | password              | mypassword     |
    | password_confirmation | mypassword     |
    | timezone              | cst            |
    | admin                 | false          |
    | telephone             | 444-4444       |
    Then the person "edgar@ruth.com" should be activated
    When I deactivate the person "edgar@ruth.com"
    Then the person "edgar@ruth.com" should be deactivated
    When I activate the person "edgar@ruth.com"
    Then the person "edgar@ruth.com" should be activated
    Then I delete the person "edgar@ruth.com"

  @wip
  Scenario: Resetting a Person's password
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And I use local person API
    Then I create a person with the following:
    | first_name            | Edgar          |
    | last_name             | Ruth           |
    | email                 | edgar@ruth.com |
    | password              | mypassword     |
    | password_confirmation | mypassword     |
    | timezone              | cst            |
    | admin                 | false          |
    | telephone             | 444-4444       |
    Then there should be a person "edgar@ruth.com"
    Then I reset the password of "edgar@ruth.com"
