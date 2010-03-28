@clean
Feature: Managing Clients

  Scenario: Adding, Updating, and Removing a Client
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client                                  |
    | details | Building API Widgets across the country |
    Then there should be a client "Client"
    When I update the client "Client" with the following:
    | name    | Updated Client                      |
    | details | Building API Widgets in the Midwest |
    Then the client "Updated Client" should have the following attributes:
    | details | Building API Widgets in the Midwest |
    When I delete the client "Updated Client"
    Then there should not be a client "Updated Client"

  Scenario: Activating and Deactivating a Client
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client                                  |
    | details | Building API Widgets across the country |
    Then the client "Client" should be activated
    When I deactivate the client "Client"
    Then the client "Client" should be deactivated
    When I activate the client "Client"
    Then the client "Client" should be activated
    Then I delete the client "Client"
    
