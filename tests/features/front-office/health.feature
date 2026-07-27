@api @frontoffice @health
Feature: LIS Front Office - Health Checks

  Background: Ensure the front office application is running
    Given the LIS Front Office application is running

  Scenario: Check the health of the front office application
    When I check the health endpoint
    Then I should receive a healthy response
