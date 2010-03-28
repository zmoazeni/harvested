@clean
Feature: Managing Tasks

  Scenario: Adding, Updating, and Removing a Task
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a task with the following:
    | name        | Test Task |
    | billable    | true      |
    | deactivated | false     |
    | hourly_rate | 120       |
    Then there should be a task "Test Task"
    When I update the task "Test Task" with the following:
    | name        | Updated Task |
    | hourly_rate | 100.0        |
    | deactivated | true         |
    | billable    | false        |
    | default     | true         |
    Then the task "Updated Task" should have the following attributes:
    | hourly_rate | 100.0 |
    | deactivated | true  |
    | active?     | false |
    | billable    | false |
    | default?    | true  |
    When I delete the task "Updated Task"
    Then there should not be a task "Updated Task"
