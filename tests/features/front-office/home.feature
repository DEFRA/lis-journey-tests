@ui @frontoffice @dev
Feature: LIS Front Office Home Page

    @accessibility
    Scenario: Home Page
        Given I am on the LIS Front Office home page
        Then the unauthenticated LIS Front Office home page should be loaded correctly
        And the LIS Front Office home page should be accessible

    Scenario: Home Page - Sign In as a user with a single CPH holding
        Given I am on the LIS Front Office home page
        When I sign in as a front office user with a single CPH holding
        Then the front office user should be signed in successfully
        And the authenticated LIS Front Office home page should be loaded correctly

