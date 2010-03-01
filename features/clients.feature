Feature: Managing Clients

  Scenario: Adding, Updating, and Removing a Client
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name    | API Widgets Inc.                        |
    | details | Building API Widgets across the country |
    Then there should be a client with the name "API Widgets Inc."
    And I should retrieve the client named "API Widgets Inc." by id
    When I update the client named "API Widgets Inc." with the following description "Building API Widgets in the Midwest"
    Then the description of "API Widgets Inc." should be "Building API Widgets in the Midwest"
    When I delete the client named "API Widgets Inc."
    Then there should not be a client with the name "API Widgets Inc."


  Scenario: Activating and Deactivating a Client
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I create a client with the following:
    | name        | API Widgets Inc.                        |
    | description | Building API Widgets across the country |
    Then the client named "API Widgets Inc." should be activated
    When I deactivate the client named "API Widgets Inc."
    Then the client named "API Widgets Inc." should be deactivated
    When I activate the client named "API Widgets Inc."
    Then the client named "API Widgets Inc." should be activated
    
