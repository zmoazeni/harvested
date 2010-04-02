@clean
Feature: Account API

  Scenario: Requesting Rate Limit
    Given I am using the credentials from "./support/harvest_credentials.yml"
    When I request the current rate limit I should get the following:
    | max_calls | 40 |
