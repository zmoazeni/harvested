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
