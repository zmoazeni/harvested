@disconnected
Feature: Handling Harvest Errors

  Scenario: Raising Bad Responses
    Given I am using the credentials from "./support/harvest_credentials.yml"
    
    Given the next request will receive a bad request response
    When I make a request with the standard client
    Then a 400 error should be raised
    
    Given the next request will receive a not found response
    When I make a request with the standard client
    Then a 404 error should be raised
    
    Given the next request will receive a bad gateway response
    When I make a request with the standard client
    Then a 502 error should be raised
    
    Given the next request will receive a server error response
    When I make a request with the standard client
    Then a 500 error should be raised
    
    Given the next request will receive a rate limit response
    When I make a request with the standard client
    Then a 503 error should be raised