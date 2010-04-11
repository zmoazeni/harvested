@clean
Feature: Time Tracking

  Scenario: Adding, Updating, and Deleting Time Entries
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And I create a client with the following:
    | name    | Time Client                  |
    | details | Client to track time against |
    And I create a project for the client "Time Client" with the following:
    | name   | Time Project |
    | active | true         |
    And I create a task with the following:
    | name        | Time Task |
    | billable    | true      |
    | hourly_rate | 120       |
    And I assign the task "Time Task" to the project "Time Project"
    When I create a time entry for the project "Time Project" and the task "Time Task" with the following:
    | notes    | Test api support |
    | hours    | 3.0              |
    | spent_at | 12/28/2009       |
    Then there should be a time entry "Test api support" on "12/28/2009"
    When I update the time entry "Test api support" on "12/28/2009" with the following:
    | hours | 4.0 |
    Then the time entry "Test api support" on "12/28/2009" should have the following attributes:
    | hours | 4.0 |
    When I delete the time entry "Test api support" on "12/28/2009"
    Then there should not be a time entry "Test api support" on "12/28/2009"
    
  Scenario: Toggling Timers
