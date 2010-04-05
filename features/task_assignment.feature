@clean
Feature: Task Assignments
  
  Scenario: Adding and Updating a Task on a Project
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
    When I update the task "Test Task" for the project "Test Project" with the following:
    | hourly_rate | 75    |
    | billable    | false |
    Then the task "Test Task" for the project "Test Project" should have the following attributes:
    | hourly_rate | 75.0  |
    | billable?   | false |
    | active?     | true  |
  
  Scenario: Removing Tasks on a project
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
    | name | Test Task1 |
    When I create a task with the following:
    | name | Test Task2 |
    Then there should be a task "Test Task1"
    Then there should be a task "Test Task2"
    When I assign the task "Test Task1" to the project "Test Project"
    When I assign the task "Test Task2" to the project "Test Project"
    Then the task "Test Task1" should be assigned to the project "Test Project"
    Then the task "Test Task2" should be assigned to the project "Test Project"
    When I remove the task "Test Task1" from the project "Test Project"
    Then the task "Test Task1" should not be assigned to the project "Test Project"
    When I try to remove the task "Test Task2" from the project "Test Project"
    Then a 400 error should be raised
  
  Scenario: Removing a task that has recorded hours
  
  Scenario: Creating a task and immediately assigning it
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client Projects                         |
    | details | Building API Widgets across the country |
    When I create a project for the client "Client Projects" with the following:
    | name   | Test Project            |
    | active | true                    |
    | notes  | project to test the api |
    Then there should be a project "Test Project"
    When I create and assign a task "Created Task" to the project "Test Project"
    Then there should be a task "Created Task"
    Then the task "Created Task" should be assigned to the project "Test Project"
