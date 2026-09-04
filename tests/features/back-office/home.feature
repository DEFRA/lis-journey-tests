@ui @backoffice
Feature: LIS Back Office Home Page

  Scenario: Home Page
    Given I am on the LIS Back Office home page
    When I sign in as a standard user
    Then the user should be signed in successfully
    And the LIS Back Office home page should be loaded correctly