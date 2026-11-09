@ui @frontoffice @dev
Feature: Cattle on holding - View Holding Details

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - No CPH holdings - User is told no holdings are linked to their account
        Given I am authenticated as a front office user with no CPH holding
        Then I should be informed I have no holdings associated to my account

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - Multiple CPH holdings - All holdings linked to the user are listed
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
    Scenario: Cattle on holding - View Holding Details - Single CPH holding - Holding details tab shows the CPH number, holding name, address and herd mark
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
    Scenario: Cattle on holding - View Holding Details - Multiple CPH holdings - Holding details tab shows the details of the selected CPH
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
    Scenario: Cattle on holding - View Holding Details - Multiple CPH holdings - CPH number is shown as the caption when the holding name is missing
        Given I am authenticated as a front office user with a multiple CPH holding
        And I click the "22/003/0003" CPH number link
        When I click the Cattle on holding link
        When I select the "Holding details" tab
        Then the "Holding details" tab should be active
        And the holding details caption should display "22/003/0003"

    @LREG-531
    Scenario: Cattle on holding - View Holding Details - Single CPH holding - User cannot view a holding that is not linked to their account
        Given I am authenticated as a front office user with a single CPH holding
        When I navigate to the "cattle" holdings detail page for the CPH "22/003/0003"
        Then I should not be able to view the CPH holding