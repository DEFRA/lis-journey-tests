@ui @frontoffice @dev
Feature: Cattle Home Page

    Background: Sign in as a user with a single CPH holding
        Given I am authenticated as a front office user with a single CPH holding

    @LREG-894
    Scenario: Cattle Home - Help and Support - GOV.UK guidance for cattle link opens the cattle keeping guidance
        When I click the GOV.UK guidance for cattle link
        Then I should be navigated to the "Keeping cattle, bison and buffalo in England and Wales" page and the web address contains "keeping-cattle-bison-and-buffalo-in-england-and-wales"

    @LREG-894
    Scenario: Cattle Home - Help and Support - Contact BCMS link opens the British Cattle Movement Service page
        When I click the Contact BCMS link
        Then I should be navigated to the "Latest from the British Cattle Movement Service" page and the web address contains "british-cattle-movement-service"