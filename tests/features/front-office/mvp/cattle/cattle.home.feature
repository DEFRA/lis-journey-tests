@ui @frontoffice @dev
Feature: Cattle Home Page

    Background: Background name: Cattle Home Page
        Given I am authenticated as a front office user with a single CPH holding

    @LREG-894
    Scenario: Cattle Home - Help and Support links - Gov.uk guidance for cattle
        Given I am authenticated as a front office user with a single CPH holding
        When I click the GOV.UK guidance for cattle link
        Then I should be navigated to the "Keeping cattle, bison and buffalo in England and Wales" page and the web address contains "keeping-cattle-bison-and-buffalo-in-england-and-wales"

    @LREG-894
    Scenario Outline: Cattle Home - Help and Support links - Contact BCMS
        Given I am authenticated as a front office user with a single CPH holding
        When I click the Contact BCMS link
        Then I should be navigated to the "Latest from the British Cattle Movement Service" page and the web address contains "british-cattle-movement-service"