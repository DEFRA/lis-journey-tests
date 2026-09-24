@ui @frontoffice
Feature: LIS Front Office Home Page

    @accessibility @dev
    Scenario: Home Page
        Given I am on the LIS Front Office home page
        Then the unauthenticated LIS Front Office home page should be loaded correctly
        And the LIS Front Office home page should be accessible

    Scenario: Home Page - Sign In as a user with a single CPH holding
        Given I am authenticated as a front office user with a single CPH holding
        Then the authenticated LIS Front Office home page should be loaded correctly

    @LREG-531
    Scenario: Cattle Home - View Holding Details
        Given I am authenticated as a front office user with a single CPH holding
        When I select the Cattle species option from the species list
        Then the "Holding details" navigation link should be active
        And the holding details caption should display "Oakfield Farm"
        And the holding details heading should display "Holding details"
        And I should see the following holding details for the CPH:
            | CPH number  | Holding name  | Business name | Address                                                    | Herd mark |
            | 22/001/0001 | Oakfield Farm | Not supplied  | Oakfield FarmChurch LaneShrewsburyShropshireSY4 1ABEngland | UK 324537 |

    @LREG-531
    Scenario: Cattle Home - View Holding Details - Display CPH number as caption when holding name is missing
        Given I am authenticated as a front office user with a single CPH holding
        When I navigate to the "cattle" holdings detail page for the CPH "22/003/0003"
        Then the holding details caption should display "22/003/0003"
        And I should see the following holding details for the CPH:
            | CPH number  | Holding name | Business name | Address                                                        | Herd mark |
            | 22/003/0003 | Not supplied | Not supplied  | Meadow View FarmMill LaneLavendonBuckinghamshireMK1 1ABEngland | UK 324788 |
