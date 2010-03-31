@clean
Feature: Managing People

  Scenario: Adding and Removing a Person
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
    Then I delete the person "jonah@example.com"
