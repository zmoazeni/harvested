@disconnected
Feature: Robust Client

  Background:
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the rate limit status indicates I'm under my limit

  Scenario: Robust Client waiting for Rate Limit resets
    Given the next request will receive a rate limit response with a refresh in 5 seconds
    When I make a request with the robust client
    Then the robust client should wait 5 seconds for the rate limit to reset
    And I should be able to make a request again
    
  Scenario: Robust Client waiting for Rate Limit resets
    Given the next request will receive a rate limit response without a refresh set
    When I make a request with the robust client
    Then the robust client should wait 16 seconds for the rate limit to reset
    And I should be able to make a request again
    
  Scenario: Robust Client retrying Bad Gateway and Server Error responses
    Given the next 2 requests will receive a bad gateway response
    When I make a request with the robust client
    Then no errors should be raised
    
    Given the next 3 requests will receive a server error response
    When I make a request with the robust client
    Then no errors should be raised
  
  Scenario: Robust Client retrying HTTP Errors
    Given the next 2 requests will receive an HTTP Error
    When I make a request with the robust client
    Then no errors should be raised
  
  Scenario: Robust Client stop retrying Bad Gateway and Server Error responses
    Given the next 6 requests will receive a bad gateway response
    When I make a request with the robust client
    Then a 502 error should be raised
    
    Given the next 3 requests will receive a server error response
    When I make a request with the robust client with 2 max retries
    Then a 500 error should be raised
    
  Scenario: Check rate limit before retrying bad gateway requests
    Given the next request will receive a bad gateway response
    And the rate limit status indicates I'm over my limit
    When I make a request with the robust client
    Then the robust client should wait 16 seconds for the rate limit to reset
    And I should be able to make a request again