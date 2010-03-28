@clean
Feature: Managing Projects

  Scenario: Adding, Updating, and Removing a Project
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client Projects                         |
    | details | Building API Widgets across the country |
    When I create a project for the client "Client Projects" with the following:
    | name   | Test Project            |
    | active | true                    |
    | notes  | project to test the api |
    Then there should be a project "Test Project"
    When I update the project "Test Project" with the following:
    | name        | Updated Project |
    | code        | new-code        |
    | bill_by     | Project         |
    | hourly_rate | 150             |
    Then the project "Updated Project" should have the following attributes:
    | name        | Updated Project |
    | code        | new-code        |
    | bill_by     | Project         |
    | hourly_rate | 150             |
    When I delete the project "Updated Project"
    Then there should not be a project "Updated Project"
    
  Scenario: Activating and Deactivating a Project
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And I create a client with the following:
    | name    | Client Projects                         |
    | details | Building API Widgets across the country |
    And I create a project for the client "Client Projects" with the following:
    | name   | Test Project            |
    | active | true                    |
    | notes  | project to test the api |
    Then the project "Test Project" should be activated
    When I deactivate the project "Test Project"
    Then the project "Test Project" should be deactivated
    When I activate the project "Test Project"
    Then the project "Test Project" should be activated
