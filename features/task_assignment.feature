@clean
Feature: Task Assignments

  Scenario: Scenario: Adding, Updating, and Removing a Task on a Project
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client Projects                         |
    | details | Building API Widgets across the country |
    When I create a project for the client "Client Projects" with the following:
    | name   | Test Project            |
    | active | true                    |
    | notes  | project to test the api |
    Then there should be a project "Test Project"
    When I create a task with the following:
    | name        | Test Task |
    | billable    | true      |
    | deactivated | false     |
    | hourly_rate | 120       |
    Then there should be a task "Test Task"
    When I assign the task "Test Task" to the project "Test Project"
    Then the task "Test Task" should be assigned to the project "Test Project"
    