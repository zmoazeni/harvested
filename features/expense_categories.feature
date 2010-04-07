@clean
Feature: Expense Categories

  Scenario: Adding, Updating, and Removing an Expense Category
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create an expense category with the following:
    | name       | Mileage |
    | unit_name  | Miles   |
    | unit_price | 0.485   |
    Then there should be an expense category "Mileage"
    When I update the expense category "Mileage" with the following:
    | unit_name   | Kilometers |
    | deactivated | true       |
    | unit_price  | 1.2        |
    Then the expense category "Mileage" should have the following attributes:
    | unit_name   | Kilometers |
    | unit_price  | 1.2        |
    | deactivated | true       |
    | active?     | false      |
    When I delete the expense category "Mileage"
    Then there should not be an expense category "Mileage"
