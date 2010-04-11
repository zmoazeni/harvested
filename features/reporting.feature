@clean
Feature: Harvest Reporting

  Background:
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And I create a client with the following:
    | name    | Report Client         |
    | details | Client to run reports |
    And I create a project for the client "Report Client" with the following:
    | name | Report Project1 |
    And I create a project for the client "Report Client" with the following:
    | name | Report Project2 |

  Scenario: Time Entry Reporting
    Given I create a task with the following:
    | name        | Report Task |
    | billable    | true        |
    | hourly_rate | 120         |
    And I assign the task "Report Task" to the project "Report Project1"
    And I assign the task "Report Task" to the project "Report Project2"
    And I create a time entry for the project "Report Project1" and the task "Report Task" with the following:
    | notes    | project1 time |
    | hours    | 2.0           |
    | spent_at | 12/28/2009    |
    And I create a time entry for the project "Report Project2" and the task "Report Task" with the following:
    | notes    | project2 time |
    | hours    | 2.0           |
    | spent_at | 12/28/2009    |
    When I run a project report for "Report Project1" for "12/20/2009" and "12/30/2009" the following entries should be returned:
    | project1 time |
    When I run a project report for "Report Project1" for "12/20/2009" and "12/30/2009" the following entries should not be returned:
    | project2 time |
    When I run a a project report for "Report Project1" for "12/20/2009" and "12/30/2009" filtered by my user the following entries should be returned:
    | project1 time |
    When I run a a project report for "Report Project1" for "12/20/2009" and "12/30/2009" filtered by my user the following entries should not be returned:
    | project2 time |
    When I run a people report for my user for "12/20/2009" and "12/30/2009" the following entries should be returned:
    | project1 time |
    | project2 time |
  
  @wip
  Scenario: People Reports filtered by Project
    Given I create a task with the following:
    | name        | Report Task |
    | billable    | true        |
    | hourly_rate | 120         |
    And I assign the task "Report Task" to the project "Report Project1"
    And I assign the task "Report Task" to the project "Report Project2"
    And I create a time entry for the project "Report Project1" and the task "Report Task" with the following:
    | notes    | project1 time |
    | hours    | 2.0           |
    | spent_at | 12/28/2009    |
    And I create a time entry for the project "Report Project2" and the task "Report Task" with the following:
    | notes    | project2 time |
    | hours    | 2.0           |
    | spent_at | 12/28/2009    |
    When I run a people report for my user for "12/20/2009" and "12/30/2009" filtered by the project "Report Project1" the following entries should be returned:
    | project1 time |
    When I run a people report for my user for "12/20/2009" and "12/30/2009" filtered by the project "Report Project1" the following entries should not be returned:
    | project2 time |
    
  Scenario: Expenses by People
    Given I create an expense category with the following:
    | name       | Conference |
    | unit_name  | Ticket     |
    | unit_price | 300        |
    And I create an expense for the project "Report Project1" with the category "Conference" with the following:
    | notes      | RubyConf   |
    | total_cost | 300        |
    | spent_at   | 12/28/2009 |
    When I run an expense report for my user for "12/20/2009" and "12/30/2009" the following entries should be returned:
    | RubyConf |
