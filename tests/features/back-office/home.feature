@ui @backoffice
Feature: LIS Back Office Home Page

# Revisit when Back Office development is complete.
@fixme
  Scenario: Verify the back office home page loads for a signed in standard user
    Given I am authenticated as a back office standard user
    And the authenticated LIS Back Office home page should be loaded correctly