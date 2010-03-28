@clean
Feature: Managing Clients

  Scenario: Adding, Updating, and Removing a Client
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client                        |
    | details | Building API Widgets across the country |
    Then there should be a client with the name "Client"
    And I should be able to retrieve the client named "Client" by id
    When I update the client named "Client" with the following:
    | name    | Updated Client                    |
    | details | Building API Widgets in the Midwest |
    Then the client named "Updated Client" should have the following attributes:
    | details | Building API Widgets in the Midwest |
    When I delete the client named "Updated Client"
    Then there should not be a client with the name "Updated Client"


  Scenario: Activating and Deactivating a Client
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | Client                        |
    | details | Building API Widgets across the country |
    Then the client named "Client" should be activated
    When I deactivate the client named "Client"
    Then the client named "Client" should be deactivated
    When I activate the client named "Client"
    Then the client named "Client" should be activated
    Then I delete the client named "Client"
    
