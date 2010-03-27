Feature: The API should respect rate limits

  Scenario: Waiting for Rate Limit resets
    Given I am using the credentials from "./support/harvest_credentials.yml"
    And the next request will rate limit for 5 seconds
    When I hit the rate limit
    Then the API should wait for the rate limit to reset
    And I should be able to make a request again