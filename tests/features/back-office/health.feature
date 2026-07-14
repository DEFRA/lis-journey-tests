@api @backoffice @health
Feature: LIS Back Office - Health Checks

  Background: Ensure the back office application is running
    Given the LIS Back Office application is running

  Scenario: Check the health of the back office application
    When I check the health endpoint
    Then I should receive a healthy response
