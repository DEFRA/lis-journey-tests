@ui @frontoffice @dev
Feature: Cattle on holding - View Holding Details

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - No CPH holdings
        Given I am authenticated as a front office user with no CPH holding
        Then I should be informed I have no holdings associated to my account

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - Multiple CPH holdings
        Given I am authenticated as a front office user with multiple CPH holdings
        Then I should see the following CPH holdings:
            | CPH         | Holding name   | Postcode     | Role          |
            | 22/002/0002 | Fairfield Farm | Not supplied | Owner, keeper |
            | 22/003/0003 | Not supplied   | Not supplied | Owner, keeper |
            | 22/004/0004 | Hilltop Farm   | Not supplied | Owner, keeper |
            | 22/005/0005 | Riverside Farm | Not supplied | Owner, keeper |
            | 22/006/0006 | Long Acre Farm | Not supplied | Owner, keeper |
            | 22/007/0007 | Orchard Farm   | Not supplied | Owner, keeper |

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - Single CPH holding
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        When I select the "Holding details" tab
        Then the "Holding details" tab should be active
        And the holding details caption should display "Oakfield Farm"
        And the holding details heading should display "Holding details"
        And I should see the following holding details for the CPH:
            | CPH number  | Holding name  | Address                                                    | Herd mark |
            | 22/001/0001 | Oakfield Farm | Oakfield FarmChurch LaneShrewsburyShropshireSY4 1ABEngland | UK 324537 |

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - Multiple CPH holding - Display CPH number as caption when holding name is missing
        Given I am authenticated as a front office user with a multiple CPH holding
        And I click the "22/004/0004" CPH number link
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name | Cattle on holding | In Progress | Cattle Errors |
            | 22/004/0004 | Hilltop Farm | 1                 | 0           | 0             |
        When I click the Cattle on holding link
        When I select the "Holding details" tab
        Then the "Holding details" tab should be active
        And I should see the following holding details for the CPH:
            | CPH number  | Holding name | Address                                                     | Herd mark |
            | 22/004/0004 | Hilltop Farm | Hilltop FarmRidge RoadLavendonBuckinghamshireMK1 1ACEngland | UK 324789 |

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - Single CPH holding - Should not be able to see any other holding that is not associated
        Given I am authenticated as a front office user with a single CPH holding
        When I navigate to the "cattle" holdings detail page for the CPH "22/003/0003"
        Then I should not be able to view the CPH holding