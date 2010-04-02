@disconnected
Feature: Robust Client

  Scenario: Robust Client waiting for Rate Limit resets
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the next request will receive a rate limit response with a refresh in 5 seconds
    When I make a request with the robust client
    Then the robust client should wait 5 seconds for the rate limit to reset
    And I should be able to make a request again
    
  Scenario: Robust Client waiting for Rate Limit resets
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the next request will receive a rate limit response without a refresh set
    When I make a request with the robust client
    Then the robust client should wait 16 seconds for the rate limit to reset
    And I should be able to make a request again
    
  Scenario: Robust Client retrying Bad Gateway and Server Error responses
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the next 2 requests will receive a bad gateway response
    When I make a request with the robust client
    Then no errors should be raised
    
    Given the next 3 requests will receive a server error response
    When I make a request with the robust client
    Then no errors should be raised
  
  Scenario: Robust Client retrying HTTP Errors
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the next 2 requests will receive an HTTP Error
    When I make a request with the robust client
    Then no errors should be raised
  
  Scenario: Robust Client stop retrying Bad Gateway and Server Error responses
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the next 6 requests will receive a bad gateway response
    When I make a request with the robust client
    Then a 502 error should be raised
    
    Given the next 3 requests will receive a server error response
    When I make a request with the robust client with 2 max retries
    Then a 500 error should be raised
    