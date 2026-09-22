@ui @backoffice
Feature: LIS Back Office Home Page

  Scenario: Home Page
    Given I am authenticated as a back office standard user
    And the authenticated LIS Back Office home page should be loaded correctly