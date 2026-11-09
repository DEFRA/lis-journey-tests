@ui @frontoffice @dev
Feature: LIS Front Office Home Page

    @accessibility
    Scenario: Verify the LIS Front Office home page loads and is accessible
        Given I am on the LIS Front Office home page
        Then the LIS Front Office home page should be loaded correctly
        And the LIS Front Office home page should be accessible