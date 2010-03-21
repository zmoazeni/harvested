Feature: Managing Client Contacts

  Scenario: Adding, Updating, and Removing a Contact
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And I create a client with the following:
    | name    | API Widgets Inc.                        |
    | details | Building API Widgets across the country |
    When I create a contact for the client named "API Widgets Inc." with the following:
    | email        | jane@doe.com |
    | first_name   | Jane         |
    | last_name    | Doe          |
    | phone_office | 555.123.4567 |
    | phone_mobile | 555.333.1111 |
    | fax          | 555.222.1111 |
    Then there should be a contact "jane@doe.com"
    And there should be a contact for the client named "API Widgets Inc." with an email address "jane@doe.com"
    When I update the contact "jane@doe.com" with the following:
    | last_name | Smith |
    Then the contact "jane@doe.com" should have the following attributes:
    | last_name | Smith |
    When I delete the contact "jane@doe.com"
    Then there should not be a contact "jane@doe.com"
    Then I delete the client named "API Widgets Inc."
