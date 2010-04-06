@clean
Feature: User Assignments
  
  Scenario: Adding and Updating a User on a Project
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client Projects                         |
    | details | Building API Widgets across the country |
    When I create a project for the client "Client Projects" with the following:
    | name   | Test Project            |
    | active | true                    |
    | notes  | project to test the api |
    Then there should be a project "Test Project"
    When I create a user with the following:
    | first_name            | Edgar          |
    | last_name             | Ruth           |
    | email                 | edgar@ruth.com |
    | password              | mypassword     |
    | password_confirmation | mypassword     |
    Then there should be a user "edgar@ruth.com"
    When I assign the user "edgar@ruth.com" to the project "Test Project"
    Then the user "edgar@ruth.com" should be assigned to the project "Test Project"
    When I update the user "edgar@ruth.com" on the project "Test Project" with the following:
    | hourly_rate     | 50.0 |
    | project_manager | true |
    Then the user "edgar@ruth.com" on the project "Test Project" should have the following attributes:
    | active?         | true |
    | hourly_rate     | 50.0 |
    | project_manager | true |
    When I remove the user "edgar@ruth.com" from the project "Test Project"
    Then the user "edgar@ruth.com" should not be assigned to the project "Test Project"
      
  Scenario: Removing a user from a project that has recorded hours